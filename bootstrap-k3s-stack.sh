#!/usr/bin/env bash
set -euo pipefail

# Incremental k3s stack bootstrap for Ubuntu
# - Detects existing installations first
# - Prompts before each change
# - Leaves existing cluster components untouched by default

log(){ printf "\n\033[1;32m[+] %s\033[0m\n" "$*"; }
warn(){ printf "\n\033[1;33m[!] %s\033[0m\n" "$*"; }
err(){ printf "\n\033[1;31m[✗] %s\033[0m\n" "$*"; }

DRY_RUN=0
DRY_RUN_REUSE=()
DRY_RUN_INSTALL=()
DRY_RUN_SKIP=()
DRY_RUN_WARNINGS=()

need_cmd() { command -v "$1" >/dev/null 2>&1; }
pkg_installed() { dpkg -s "$1" >/dev/null 2>&1; }
service_active() { systemctl is-active --quiet "$1"; }
mount_exists() { mountpoint -q "$1"; }

prompt() {
  local var="$1" default="$2" msg="$3"
  local val
  read -rp "$msg [$default]: " val
  val="${val:-$default}"
  printf -v "$var" '%s' "$val"
}

prompt_yesno() {
  local var="$1" default="$2" msg="$3"
  local val
  local d="$default"
  read -rp "$msg [$d] (y/n): " val
  val="${val:-$d}"
  case "$val" in
    y|Y) printf -v "$var" 'y' ;;
    n|N) printf -v "$var" 'n' ;;
    *) warn "Invalid input, using default: $d"; printf -v "$var" '%s' "$d" ;;
  esac
}

sudo_keepalive() {
  if ! sudo -n true 2>/dev/null; then
    log "Requesting sudo..."
    sudo -v
  fi
  ( while true; do sudo -n true; sleep 30; done ) >/dev/null 2>&1 &
  SUDO_KA_PID=$!
  trap 'kill ${SUDO_KA_PID:-0} >/dev/null 2>&1 || true' EXIT
}

kubectl_k3s() { sudo k3s kubectl "$@"; }

namespace_exists() { kubectl_k3s get namespace "$1" >/dev/null 2>&1; }
deployment_exists() { kubectl_k3s get deployment "$2" -n "$1" >/dev/null 2>&1; }
secret_exists() { kubectl_k3s get secret "$2" -n "$1" >/dev/null 2>&1; }
storageclass_exists() { kubectl_k3s get storageclass "$1" >/dev/null 2>&1; }
clusterissuer_exists() { kubectl_k3s get clusterissuer "$1" >/dev/null 2>&1; }
helm_release_exists() {
  need_cmd helm || return 1
  helm status "$1" -n "$2" >/dev/null 2>&1
}

get_first_ingress_host() {
  local ns="$1" name="$2"
  kubectl_k3s get ingress "$name" -n "$ns" -o jsonpath='{.spec.rules[0].host}' 2>/dev/null || true
}

run_cmd() {
  local desc="$1"
  shift

  if [[ "$DRY_RUN" == "1" ]]; then
    log "[dry-run] ${desc}"
    printf '  '
    printf '%q ' "$@"
    printf '\n'
    return 0
  fi

  "$@"
}

run_shell() {
  local desc="$1" cmd="$2"

  if [[ "$DRY_RUN" == "1" ]]; then
    log "[dry-run] ${desc}"
    echo "  ${cmd}"
    return 0
  fi

  bash -lc "$cmd"
}

apply_manifest() {
  local desc="$1" manifest="$2"

  if [[ "$DRY_RUN" == "1" ]]; then
    log "[dry-run] ${desc}"
    printf '%s\n' "$manifest"
    return 0
  fi

  printf '%s\n' "$manifest" | kubectl_k3s apply -f -
}

parse_args() {
  while (($# > 0)); do
    case "$1" in
      --dry-run)
        DRY_RUN=1
        ;;
      -h|--help)
        echo "Usage: $0 [--dry-run]"
        exit 0
        ;;
      *)
        err "Unknown argument: $1"
        exit 1
        ;;
    esac
    shift
  done
}

track_reuse() {
  [[ "$DRY_RUN" == "1" ]] || return 0
  DRY_RUN_REUSE+=("$1")
}

track_install() {
  [[ "$DRY_RUN" == "1" ]] || return 0
  DRY_RUN_INSTALL+=("$1")
}

track_skip() {
  [[ "$DRY_RUN" == "1" ]] || return 0
  DRY_RUN_SKIP+=("$1")
}

track_warning() {
  [[ "$DRY_RUN" == "1" ]] || return 0
  DRY_RUN_WARNINGS+=("$1")
}

print_dry_run_summary() {
  [[ "$DRY_RUN" == "1" ]] || return 0

  echo
  log "Dry-run summary"

  echo "  Reuse existing:"
  if (( ${#DRY_RUN_REUSE[@]} == 0 )); then
    echo "    - none"
  else
    printf '    - %s\n' "${DRY_RUN_REUSE[@]}"
  fi

  echo "  Would install/configure:"
  if (( ${#DRY_RUN_INSTALL[@]} == 0 )); then
    echo "    - none"
  else
    printf '    - %s\n' "${DRY_RUN_INSTALL[@]}"
  fi

  echo "  Skipped by choice/preflight:"
  if (( ${#DRY_RUN_SKIP[@]} == 0 )); then
    echo "    - none"
  else
    printf '    - %s\n' "${DRY_RUN_SKIP[@]}"
  fi

  echo "  Warnings:"
  if (( ${#DRY_RUN_WARNINGS[@]} == 0 )); then
    echo "    - none"
  else
    printf '    - %s\n' "${DRY_RUN_WARNINGS[@]}"
  fi
}

wait_pods_ready() {
  local ns="$1" timeout="${2:-300}"
  if [[ "$DRY_RUN" == "1" ]]; then
    log "[dry-run] Skipping wait for namespace '${ns}'."
    return
  fi

  log "Waiting for pods in namespace '$ns' to be Ready (timeout ${timeout}s)..."
  local start now
  start="$(date +%s)"
  while true; do
    if kubectl_k3s get pods -n "$ns" >/dev/null 2>&1; then
      local not_ready
      not_ready="$(kubectl_k3s get pods -n "$ns" --no-headers 2>/dev/null | awk '
        {status=$3}
        status!="Running" && status!="Completed" {print; next}
      ')"
      local bad_ready
      bad_ready="$(kubectl_k3s get pods -n "$ns" --no-headers 2>/dev/null | awk '
        $3=="Running" {
          split($2,a,"/");
          if (a[1]!=a[2]) print
        }
      ')"
      if [[ -z "$not_ready" && -z "$bad_ready" ]]; then
        log "Namespace '$ns' looks Ready."
        break
      fi
    fi
    now="$(date +%s)"
    if (( now - start > timeout )); then
      warn "Timeout waiting for namespace '$ns'. Showing pods:"
      kubectl_k3s get pods -n "$ns" -o wide || true
      break
    fi
    sleep 5
  done
}

ensure_namespace() {
  local ns="$1"
  if ! namespace_exists "$ns"; then
    run_cmd "Creating namespace ${ns}" kubectl_k3s create namespace "$ns"
  fi
}

ensure_helm_repo() {
  local name="$1" url="$2"
  if [[ "$DRY_RUN" == "1" ]]; then
    log "[dry-run] Adding Helm repo ${name}"
    echo "  helm repo add ${name} ${url}"
    return
  fi
  if helm repo add "$name" "$url" >/dev/null 2>&1; then
    return
  fi
}

print_detection_summary() {
  local k3s_state="$1" helm_state="$2" cert_state="$3" longhorn_state="$4" rancher_state="$5" registry_state="$6"
  echo
  log "Detected environment"
  echo "  k3s:          ${k3s_state}"
  echo "  helm:         ${helm_state}"
  echo "  cert-manager: ${cert_state}"
  echo "  longhorn:     ${longhorn_state}"
  echo "  rancher:      ${rancher_state}"
  echo "  registry:     ${registry_state}"
}

ensure_packages() {
  local label="$1"
  shift

  local missing=()
  local pkg
  for pkg in "$@"; do
    if ! pkg_installed "$pkg"; then
      missing+=("$pkg")
    fi
  done

  if (( ${#missing[@]} == 0 )); then
    log "Required packages for ${label} are already installed."
    return
  fi

  warn "Missing OS packages for ${label}: ${missing[*]}"
  local install_pkgs="y"
  prompt_yesno install_pkgs "y" "Install the missing packages for ${label}?"
  if [[ "$install_pkgs" != "y" ]]; then
    err "Cannot continue with ${label} without those packages."
    exit 1
  fi

  log "Installing packages for ${label}..."
  run_cmd "Updating apt indexes for ${label}" sudo apt-get update -y
  run_cmd "Installing packages for ${label}" sudo apt-get install -y "${missing[@]}"
}

ensure_iscsid() {
  if service_active iscsid; then
    log "Service 'iscsid' already active."
    return
  fi

  local enable_iscsid="y"
  prompt_yesno enable_iscsid "y" "Enable and start 'iscsid' now?"
  if [[ "$enable_iscsid" == "y" ]]; then
    run_cmd "Enabling and starting iscsid" sudo systemctl enable --now iscsid
  else
    warn "Longhorn requires 'iscsid'. Skipping it may break Longhorn volumes."
  fi
}

namespace_has_user_resources() {
  local ns="$1"
  kubectl_k3s get deploy,statefulset,daemonset,job,cronjob,ingress,pvc -n "$ns" --ignore-not-found --no-headers 2>/dev/null | grep -q .
}

find_ingress_host_conflicts() {
  local host="$1" expected_ns="$2" expected_name="$3"
  kubectl_k3s get ingress -A -o jsonpath='{range .items[*]}{.metadata.namespace}{"|"}{.metadata.name}{"|"}{range .spec.rules[*]}{.host}{"\n"}{end}{end}' 2>/dev/null | \
    awk -F'|' -v host="$host" -v expected_ns="$expected_ns" -v expected_name="$expected_name" '
      $3 == host && !($1 == expected_ns && $2 == expected_name) { print $1 "/" $2 }
    '
}

count_default_storageclasses() {
  kubectl_k3s get storageclass -o jsonpath='{range .items[*]}{.metadata.name}{"|"}{.metadata.annotations.storageclass\.kubernetes\.io/is-default-class}{"\n"}{end}' 2>/dev/null | \
    awk -F'|' '$2 == "true" {count++} END {print count+0}'
}

confirm_preflight() {
  local component="$1" warnings_found="$2"

  if (( warnings_found == 0 )); then
    log "Preflight checks for ${component} passed."
    return 0
  fi

  local continue_anyway="n"
  prompt_yesno continue_anyway "n" "${component} preflight found warnings. Continue anyway?"
  if [[ "$continue_anyway" != "y" ]]; then
    warn "${component} installation cancelled."
    track_skip "${component}: cancelled after preflight warnings"
    return 1
  fi

  return 0
}

preflight_cert_manager_install() {
  local warnings_found=0

  if ! service_active k3s; then
    warn "k3s is not active, so cert-manager preflight can only be partial."
    track_warning "cert-manager: k3s is not active, preflight is partial"
    ((warnings_found+=1))
    confirm_preflight "cert-manager" "$warnings_found"
    return
  fi

  if namespace_exists cert-manager && namespace_has_user_resources cert-manager; then
    warn "Namespace 'cert-manager' already contains resources, but cert-manager was not detected as installed."
    track_warning "cert-manager: namespace already has resources"
    ((warnings_found+=1))
  fi

  confirm_preflight "cert-manager" "$warnings_found"
}

preflight_longhorn_install() {
  local data_path="$1"
  local warnings_found=0
  local default_sc_count=0

  if ! service_active k3s; then
    warn "k3s is not active, so Longhorn preflight can only be partial."
    track_warning "Longhorn: k3s is not active, preflight is partial"
    ((warnings_found+=1))
    confirm_preflight "Longhorn" "$warnings_found"
    return
  fi

  if namespace_exists longhorn-system && namespace_has_user_resources longhorn-system; then
    warn "Namespace 'longhorn-system' already contains resources, but Longhorn release was not detected."
    track_warning "Longhorn: longhorn-system namespace already has resources"
    ((warnings_found+=1))
  fi

  if storageclass_exists longhorn; then
    warn "StorageClass 'longhorn' already exists."
    track_warning "Longhorn: storageclass 'longhorn' already exists"
    ((warnings_found+=1))
  fi

  if [[ -e "$data_path" && ! -d "$data_path" ]]; then
    warn "Longhorn data path '${data_path}' exists and is not a directory."
    track_warning "Longhorn: data path '${data_path}' exists and is not a directory"
    ((warnings_found+=1))
  fi

  if [[ -d "$data_path" ]] && ! mount_exists "$data_path"; then
    warn "Longhorn data path '${data_path}' exists but is not a mount point."
    track_warning "Longhorn: data path '${data_path}' exists but is not a mount point"
    ((warnings_found+=1))
  fi

  default_sc_count="$(count_default_storageclasses)"
  if (( default_sc_count > 0 )); then
    warn "The cluster already has ${default_sc_count} default StorageClass(es)."
    track_warning "Longhorn: cluster already has ${default_sc_count} default StorageClass(es)"
    ((warnings_found+=1))
  fi

  confirm_preflight "Longhorn" "$warnings_found"
}

preflight_rancher_install() {
  local rancher_host="$1"
  local conflicts=""
  local warnings_found=0

  if ! service_active k3s; then
    warn "k3s is not active, so Rancher preflight can only be partial."
    track_warning "Rancher: k3s is not active, preflight is partial"
    ((warnings_found+=1))
    confirm_preflight "Rancher" "$warnings_found"
    return
  fi

  if namespace_exists cattle-system && namespace_has_user_resources cattle-system; then
    warn "Namespace 'cattle-system' already contains resources, but Rancher release was not detected."
    track_warning "Rancher: cattle-system namespace already has resources"
    ((warnings_found+=1))
  fi

  conflicts="$(find_ingress_host_conflicts "$rancher_host" "cattle-system" "rancher")"
  if [[ -n "$conflicts" ]]; then
    warn "Hostname '${rancher_host}' is already used by these ingress resources:"
    printf '%s\n' "$conflicts"
    track_warning "Rancher: hostname '${rancher_host}' already used by other ingress resources"
    ((warnings_found+=1))
  fi

  confirm_preflight "Rancher" "$warnings_found"
}

preflight_registry_install() {
  local registry_host="$1"
  local registry_storage_class="$2"
  local conflicts=""
  local warnings_found=0

  if ! service_active k3s; then
    warn "k3s is not active, so registry preflight can only be partial."
    track_warning "Registry: k3s is not active, preflight is partial"
    ((warnings_found+=1))
    confirm_preflight "Registry" "$warnings_found"
    return
  fi

  if namespace_exists registry && namespace_has_user_resources registry; then
    warn "Namespace 'registry' already contains resources, but the registry release was not detected."
    track_warning "Registry: registry namespace already has resources"
    ((warnings_found+=1))
  fi

  conflicts="$(find_ingress_host_conflicts "$registry_host" "registry" "registry-docker-registry")"
  if [[ -n "$conflicts" ]]; then
    warn "Hostname '${registry_host}' is already used by these ingress resources:"
    printf '%s\n' "$conflicts"
    track_warning "Registry: hostname '${registry_host}' already used by other ingress resources"
    ((warnings_found+=1))
  fi

  if [[ -n "$registry_storage_class" ]] && ! storageclass_exists "$registry_storage_class"; then
    warn "Requested StorageClass '${registry_storage_class}' does not exist."
    track_warning "Registry: storageclass '${registry_storage_class}' does not exist"
    ((warnings_found+=1))
  fi

  confirm_preflight "Registry" "$warnings_found"
}

prepare_disk_for_longhorn() {
  local data_path="$1"
  local setup_disk="n"

  if mount_exists "$data_path"; then
    log "Path ${data_path} is already a mount point. Leaving it untouched."
    run_cmd "Ensuring directory ${data_path} exists" sudo mkdir -p "$data_path"
    return
  fi

  prompt_yesno setup_disk "n" "Do you want this script to format+mount a block device to ${data_path}?"
  if [[ "$setup_disk" != "y" ]]; then
    run_cmd "Ensuring directory ${data_path} exists" sudo mkdir -p "$data_path"
    return
  fi

  local disk_dev="/dev/sdb"
  prompt disk_dev "$disk_dev" "Block device (DANGER: will be formatted)"
  warn "You chose to FORMAT ${disk_dev} and mount it at ${data_path}."

  local confirm="n"
  prompt_yesno confirm "n" "Confirm formatting ${disk_dev} (this will destroy data)"
  if [[ "$confirm" != "y" ]]; then
    err "Aborted by user."
    exit 1
  fi

  log "Formatting ${disk_dev} as ext4 and mounting it at ${data_path}..."
  run_cmd "Formatting ${disk_dev}" sudo mkfs.ext4 -F "$disk_dev"
  run_cmd "Creating ${data_path}" sudo mkdir -p "$data_path"
  run_cmd "Mounting ${disk_dev} on ${data_path}" sudo mount "$disk_dev" "$data_path"

  if ! grep -qE "^[^#]*[[:space:]]+${data_path}[[:space:]]+" /etc/fstab; then
    if [[ "$DRY_RUN" == "1" ]]; then
      log "[dry-run] Persisting mount in /etc/fstab"
      echo "  ${disk_dev}  ${data_path}  ext4  defaults  0  2"
    else
      log "Persisting mount in /etc/fstab..."
      echo "${disk_dev}  ${data_path}  ext4  defaults  0  2" | sudo tee -a /etc/fstab >/dev/null
    fi
  else
    warn "/etc/fstab already contains an entry for ${data_path}; leaving it unchanged."
  fi

  run_cmd "Reloading mounts" sudo mount -a
}

install_k3s_if_needed() {
  if service_active k3s; then
    local continue_existing="y"
    prompt_yesno continue_existing "y" "Existing k3s installation detected. Continue using it without changes?"
    if [[ "$continue_existing" != "y" ]]; then
      err "k3s is required for the remaining steps."
      exit 1
    fi
    track_reuse "k3s"
    return
  fi

  local install_k3s="y"
  prompt_yesno install_k3s "y" "k3s was not detected. Install it now?"
  if [[ "$install_k3s" != "y" ]]; then
    err "Cannot continue without k3s."
    exit 1
  fi

  track_install "k3s"
  ensure_packages "k3s installation" curl ca-certificates
  log "Installing k3s (stable channel)..."
  run_shell "Installing k3s (stable channel)" "curl -sfL https://get.k3s.io | sh -"
}

install_helm_if_needed() {
  if need_cmd helm; then
    local continue_existing="y"
    prompt_yesno continue_existing "y" "Helm is already installed. Continue using it without changes?"
    if [[ "$continue_existing" != "y" ]]; then
      err "Helm is required for chart-based installs."
      exit 1
    fi
    track_reuse "helm"
    return
  fi

  local install_helm="y"
  prompt_yesno install_helm "y" "Helm was not detected. Install it now?"
  if [[ "$install_helm" != "y" ]]; then
    err "Cannot continue without Helm."
    exit 1
  fi

  track_install "helm"
  ensure_packages "Helm installation" curl ca-certificates
  log "Installing Helm..."
  run_shell "Installing Helm" "curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash"
}

ensure_cert_manager() {
  local cert_manager_present="$1"

  if [[ "$cert_manager_present" == "y" ]]; then
    local continue_existing="y"
    prompt_yesno continue_existing "y" "cert-manager is already present. Reuse it without changes?"
    if [[ "$continue_existing" != "y" ]]; then
      err "Rancher and registry TLS setup in this script requires cert-manager."
      exit 1
    fi
    track_reuse "cert-manager"
    return
  fi

  local install_cm="y"
  prompt_yesno install_cm "y" "cert-manager is missing. Install it now?"
  if [[ "$install_cm" != "y" ]]; then
    err "Skipping cert-manager would leave TLS-dependent installs unsupported."
    exit 1
  fi

  track_install "cert-manager"
  preflight_cert_manager_install || exit 1
  log "Installing cert-manager..."
  ensure_namespace cert-manager
  run_cmd "Applying cert-manager manifest" sudo k3s kubectl apply -f https://github.com/cert-manager/cert-manager/releases/latest/download/cert-manager.yaml
  wait_pods_ready "cert-manager" 420
}

ensure_issuer() {
  local tls_choice="$1"
  local issuer_name="$2"
  local le_email="$3"
  local le_env="$4"

  if clusterissuer_exists "$issuer_name"; then
    log "ClusterIssuer '${issuer_name}' already exists. Leaving it untouched."
    track_reuse "clusterissuer/${issuer_name}"
    return
  fi

  local create_issuer="y"
  prompt_yesno create_issuer "y" "ClusterIssuer '${issuer_name}' is missing. Create it now?"
  if [[ "$create_issuer" != "y" ]]; then
    err "Cannot continue without the required ClusterIssuer."
    exit 1
  fi

  track_install "clusterissuer/${issuer_name}"
  log "Creating ClusterIssuer '${issuer_name}'..."
  if [[ "$tls_choice" == "1" ]]; then
    apply_manifest "Creating ClusterIssuer ${issuer_name}" "$(cat <<EOF
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: ${issuer_name}
spec:
  acme:
    email: ${le_email}
    server: $( [[ "$le_env" == "production" ]] && echo "https://acme-v02.api.letsencrypt.org/directory" || echo "https://acme-staging-v02.api.letsencrypt.org/directory" )
    privateKeySecretRef:
      name: ${issuer_name}-account-key
    solvers:
    - http01:
        ingress:
          ingressClassName: traefik
EOF
)"
  else
    apply_manifest "Creating ClusterIssuer ${issuer_name}" "$(cat <<EOF
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: ${issuer_name}
spec:
  selfSigned: {}
EOF
)"
  fi
}

install_longhorn_if_needed() {
  local longhorn_present="$1"
  local longhorn_data_path="$2"
  local replica_count="$3"

  if [[ "$longhorn_present" == "y" ]]; then
    local continue_existing="y"
    prompt_yesno continue_existing "y" "Longhorn is already present. Leave it unchanged and continue?"
    if [[ "$continue_existing" == "y" ]]; then
      track_reuse "Longhorn"
      return
    fi
    warn "Skipping Longhorn changes."
    track_skip "Longhorn: existing installation left untouched"
    return
  fi

  local install_longhorn="y"
  prompt_yesno install_longhorn "y" "Longhorn is missing. Install it now?"
  if [[ "$install_longhorn" != "y" ]]; then
    warn "Longhorn will not be installed."
    track_skip "Longhorn: user chose not to install"
    return
  fi

  track_install "Longhorn"
  preflight_longhorn_install "$longhorn_data_path" || return
  ensure_packages "Longhorn" open-iscsi
  ensure_iscsid
  prepare_disk_for_longhorn "$longhorn_data_path"

  log "Installing Longhorn..."
  ensure_helm_repo longhorn https://charts.longhorn.io
  run_cmd "Updating Helm repos for Longhorn" helm repo update
  ensure_namespace longhorn-system
  run_cmd "Installing Longhorn" helm install longhorn longhorn/longhorn \
    --namespace longhorn-system \
    --set defaultSettings.defaultReplicaCount="${replica_count}" \
    --set defaultSettings.defaultDataPath="${longhorn_data_path}"
  wait_pods_ready "longhorn-system" 600

  local make_default_sc="n"
  prompt_yesno make_default_sc "n" "Make Longhorn the default StorageClass?"
  if [[ "$make_default_sc" == "y" ]]; then
    if storageclass_exists longhorn; then
      run_cmd "Marking Longhorn as default StorageClass" kubectl_k3s patch storageclass longhorn -p '{"metadata":{"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}' || true
    else
      warn "StorageClass 'longhorn' was not found after installation."
    fi
  fi
}

install_rancher_if_needed() {
  local rancher_present="$1"
  local tls_choice="$2"
  local issuer_name="$3"
  local rancher_host="$4"
  local admin_pass="$5"
  local le_email="$6"
  local le_env="$7"

  if [[ "$rancher_present" == "y" ]]; then
    local continue_existing="y"
    prompt_yesno continue_existing "y" "Rancher is already present. Leave it unchanged and continue?"
    if [[ "$continue_existing" != "y" ]]; then
      warn "Rancher will be left untouched."
    fi
    track_reuse "Rancher"
    return
  fi

  local install_rancher="y"
  prompt_yesno install_rancher "y" "Rancher is missing. Install it now?"
  if [[ "$install_rancher" != "y" ]]; then
    warn "Rancher will not be installed."
    track_skip "Rancher: user chose not to install"
    return
  fi

  track_install "Rancher"
  preflight_rancher_install "$rancher_host" || return
  log "Installing Rancher..."
  ensure_helm_repo rancher-latest https://releases.rancher.com/server-charts/latest
  run_cmd "Updating Helm repos for Rancher" helm repo update
  ensure_namespace cattle-system

  if [[ "$tls_choice" == "2" ]] && ! secret_exists cattle-system rancher-tls; then
    log "Creating certificate for Rancher..."
    apply_manifest "Creating Rancher TLS certificate" "$(cat <<EOF
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: rancher-tls
  namespace: cattle-system
spec:
  secretName: rancher-tls
  issuerRef:
    name: ${issuer_name}
    kind: ClusterIssuer
  dnsNames:
  - ${rancher_host}
EOF
)"

    log "Waiting for Rancher TLS secret to be issued..."
    if [[ "$DRY_RUN" == "1" ]]; then
      log "[dry-run] Skipping wait for secret rancher-tls."
    else
      for _ in {1..60}; do
        if secret_exists cattle-system rancher-tls; then
          break
        fi
        sleep 2
      done
    fi
  fi

  if [[ "$tls_choice" == "1" ]]; then
    run_cmd "Installing Rancher" helm install rancher rancher-latest/rancher \
      --namespace cattle-system \
      --set hostname="${rancher_host}" \
      --set bootstrapPassword="${admin_pass}" \
      --set ingress.tls.source=letsEncrypt \
      --set letsEncrypt.email="${le_email}" \
      --set letsEncrypt.environment="${le_env}"
  else
    run_cmd "Installing Rancher" helm install rancher rancher-latest/rancher \
      --namespace cattle-system \
      --set hostname="${rancher_host}" \
      --set bootstrapPassword="${admin_pass}" \
      --set ingress.tls.source=secret \
      --set privateCA=true
  fi

  log "Waiting for Rancher deployment..."
  if [[ "$DRY_RUN" == "1" ]]; then
    log "[dry-run] Skipping Rancher rollout wait."
  else
    kubectl_k3s -n cattle-system rollout status deploy/rancher --timeout=10m || true
    kubectl_k3s get pods -n cattle-system -o wide || true
  fi
}

install_registry_if_needed() {
  local registry_present="$1"
  local tls_choice="$2"
  local issuer_name="$3"
  local registry_host="$4"
  local registry_size="$5"
  local registry_storage_class="$6"

  if [[ "$registry_present" == "y" ]]; then
    local continue_existing="y"
    prompt_yesno continue_existing "y" "The in-cluster registry is already present. Leave it unchanged and continue?"
    if [[ "$continue_existing" != "y" ]]; then
      warn "Registry will be left untouched."
    fi
    track_reuse "Registry"
    return
  fi

  local install_registry="y"
  prompt_yesno install_registry "y" "The in-cluster registry is missing. Install it now?"
  if [[ "$install_registry" != "y" ]]; then
    warn "Registry will not be installed."
    track_skip "Registry: user chose not to install"
    return
  fi

  track_install "Registry"
  preflight_registry_install "$registry_host" "$registry_storage_class" || return
  log "Installing the in-cluster Docker Registry..."
  ensure_helm_repo twuni https://helm.twun.io
  run_cmd "Updating Helm repos for registry" helm repo update
  ensure_namespace registry

  if [[ "$tls_choice" == "2" ]] && ! secret_exists registry registry-tls; then
    log "Creating certificate for the registry..."
    apply_manifest "Creating registry TLS certificate" "$(cat <<EOF
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: registry-tls
  namespace: registry
spec:
  secretName: registry-tls
  issuerRef:
    name: ${issuer_name}
    kind: ClusterIssuer
  dnsNames:
  - ${registry_host}
EOF
)"
  fi

  local helm_cmd=(
    helm install registry twuni/docker-registry
    --namespace registry
    --set persistence.enabled=true
    --set "persistence.size=${registry_size}"
    --set ingress.enabled=true
    --set "ingress.hosts[0]=${registry_host}"
    --set "ingress.tls[0].hosts[0]=${registry_host}"
    --set ingress.tls[0].secretName=registry-tls
  )

  if [[ -n "$registry_storage_class" ]]; then
    helm_cmd+=(--set "persistence.storageClass=${registry_storage_class}")
  fi

  if [[ "$tls_choice" == "1" ]]; then
    helm_cmd+=(--set "ingress.annotations.cert-manager\\.io/cluster-issuer=${issuer_name}")
  fi

  run_cmd "Installing the in-cluster registry" "${helm_cmd[@]}"
  wait_pods_ready "registry" 300
}

main() {
  parse_args "$@"
  sudo_keepalive

  log "Incremental bootstrap: k3s + Rancher + Longhorn + Registry (Ubuntu)"
  if [[ "$DRY_RUN" == "1" ]]; then
    warn "Running in dry-run mode. No changes will be applied."
  fi

  install_k3s_if_needed

  if service_active k3s; then
    log "Checking k3s node..."
    kubectl_k3s get nodes -o wide
  else
    warn "k3s is not active yet. Cluster-level checks will be partial until it is installed for real."
  fi

  install_helm_if_needed
  if [[ -f /etc/rancher/k3s/k3s.yaml ]]; then
    export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
  fi

  local cert_manager_present="n"
  local longhorn_present="n"
  local rancher_present="n"
  local registry_present="n"

  if deployment_exists cert-manager cert-manager; then
    cert_manager_present="y"
  fi
  if helm_release_exists longhorn longhorn-system || deployment_exists longhorn-system longhorn-driver-deployer; then
    longhorn_present="y"
  fi
  if helm_release_exists rancher cattle-system || deployment_exists cattle-system rancher; then
    rancher_present="y"
  fi
  if helm_release_exists registry registry || namespace_exists registry; then
    registry_present="y"
  fi

  local rancher_existing_host=""
  local registry_existing_host=""
  rancher_existing_host="$(get_first_ingress_host cattle-system rancher)"
  registry_existing_host="$(get_first_ingress_host registry registry-docker-registry)"

  print_detection_summary \
    "$(service_active k3s && echo present || echo missing)" \
    "$(need_cmd helm && echo present || echo missing)" \
    "$( [[ "$cert_manager_present" == "y" ]] && echo present || echo missing )" \
    "$( [[ "$longhorn_present" == "y" ]] && echo present || echo missing )" \
    "$( [[ "$rancher_present" == "y" ]] && echo present || echo missing )" \
    "$( [[ "$registry_present" == "y" ]] && echo present || echo missing )"

  local DEFAULT_DOMAIN="example.local"
  local DOMAIN="$DEFAULT_DOMAIN"
  local RANCHER_HOST="${rancher_existing_host:-rancher.${DEFAULT_DOMAIN}}"
  local REGISTRY_HOST="${registry_existing_host:-registry.${DEFAULT_DOMAIN}}"
  local ADMIN_PASS="admin"
  local REGISTRY_SIZE="20Gi"
  local LONGHORN_REPLICA_COUNT="1"
  local LONGHORN_DATA_PATH="/data"
  local REGISTRY_STORAGE_CLASS=""
  local TLS_CHOICE="2"
  local LE_EMAIL="you@example.com"
  local LE_ENV="staging"
  local ISSUER_NAME="selfsigned"

  if [[ "$longhorn_present" != "y" ]]; then
    prompt LONGHORN_DATA_PATH "$LONGHORN_DATA_PATH" "Longhorn data mount path"
    prompt LONGHORN_REPLICA_COUNT "$LONGHORN_REPLICA_COUNT" "Longhorn default replica count (1 for single-node)"
  fi

  if [[ "$rancher_present" != "y" || "$registry_present" != "y" ]]; then
    prompt DOMAIN "$DOMAIN" "Base domain (used to build hostnames)"
    prompt RANCHER_HOST "${rancher_existing_host:-rancher.${DOMAIN}}" "Rancher hostname (DNS name)"
    prompt REGISTRY_HOST "${registry_existing_host:-registry.${DOMAIN}}" "Registry hostname (DNS name)"
    prompt ADMIN_PASS "$ADMIN_PASS" "Rancher bootstrap password"
    prompt REGISTRY_SIZE "$REGISTRY_SIZE" "Registry PVC size"
    if storageclass_exists longhorn; then
      REGISTRY_STORAGE_CLASS="longhorn"
    fi
    prompt REGISTRY_STORAGE_CLASS "$REGISTRY_STORAGE_CLASS" "Registry StorageClass (blank uses cluster default)"

    echo
    echo "TLS options:"
    echo "  1) Let's Encrypt (requires public DNS + inbound 80/443)"
    echo "  2) Self-signed (works anywhere; you'll need to trust certs in browser/docker)"
    prompt TLS_CHOICE "$TLS_CHOICE" "Choose TLS mode (1/2)"
    if [[ "$TLS_CHOICE" == "1" ]]; then
      prompt LE_EMAIL "$LE_EMAIL" "Let's Encrypt email"
      prompt LE_ENV "$LE_ENV" "Let's Encrypt environment (staging/production)"
      ISSUER_NAME="letsencrypt-${LE_ENV}"
    fi
  fi

  if [[ "$rancher_present" != "y" || "$registry_present" != "y" ]]; then
    ensure_cert_manager "$cert_manager_present"
    ensure_issuer "$TLS_CHOICE" "$ISSUER_NAME" "$LE_EMAIL" "$LE_ENV"
  fi

  install_longhorn_if_needed "$longhorn_present" "$LONGHORN_DATA_PATH" "$LONGHORN_REPLICA_COUNT"
  install_rancher_if_needed "$rancher_present" "$TLS_CHOICE" "$ISSUER_NAME" "$RANCHER_HOST" "$ADMIN_PASS" "$LE_EMAIL" "$LE_ENV"
  install_registry_if_needed "$registry_present" "$TLS_CHOICE" "$ISSUER_NAME" "$REGISTRY_HOST" "$REGISTRY_SIZE" "$REGISTRY_STORAGE_CLASS"

  echo
  log "DONE. Quick checks:"
  echo "  k3s nodes:            sudo k3s kubectl get nodes"
  echo "  cert-manager pods:    sudo k3s kubectl get pods -n cert-manager"
  echo "  longhorn pods:        sudo k3s kubectl get pods -n longhorn-system"
  echo "  rancher pods:         sudo k3s kubectl get pods -n cattle-system"
  echo "  registry pods:        sudo k3s kubectl get pods -n registry"
  echo

  warn "DNS/Hosts:"
  echo "  Ensure these resolve to your VM IP:"
  echo "    ${RANCHER_HOST}"
  echo "    ${REGISTRY_HOST}"
  echo "  For local testing on the VM itself, you can add to /etc/hosts:"
  echo "    <VM-IP> ${RANCHER_HOST} ${REGISTRY_HOST}"
  echo

  if [[ "$TLS_CHOICE" == "2" ]]; then
    warn "Self-signed TLS:"
    echo "  - Your browser and Docker clients may not trust the cert by default."
    echo "  - To use the registry with docker push/pull from a machine, you typically need to trust the CA/cert."
  else
    log "Let's Encrypt TLS:"
    echo "  - Make sure ports 80/443 are reachable from the internet and DNS points to this VM."
    echo "  - If cert issuance fails, check: sudo k3s kubectl describe certificate -A"
  fi

  echo
  echo "  Rancher URL:  https://${RANCHER_HOST}"
  echo "  Registry URL: https://${REGISTRY_HOST}"
  print_dry_run_summary
}

main "$@"
