#!/usr/bin/env bash
set -euo pipefail

# k3s + Rancher + Longhorn + (in-cluster) Docker Registry bootstrap for Ubuntu
# - Interactive: TLS mode (Let's Encrypt or Self-signed)
# - Interactive defaults: hostnames, /data path, optional disk formatting+mount, replica count, etc.
#
# Usage:
#   chmod +x bootstrap-k3s-stack.sh
#   ./bootstrap-k3s-stack.sh
#
# Notes:
# - This script assumes a single-node k3s by default (production-lite). Works for multi-node too (adjust replicas/hostnames).
# - For Let's Encrypt you must have public DNS pointing to this VM and ports 80/443 reachable.
# - For Self-signed you’ll likely need to trust the CA/cert on your workstation to avoid browser/docker warnings.

log(){ printf "\n\033[1;32m[+] %s\033[0m\n" "$*"; }
warn(){ printf "\n\033[1;33m[!] %s\033[0m\n" "$*"; }
err(){ printf "\n\033[1;31m[✗] %s\033[0m\n" "$*"; }

need_cmd() { command -v "$1" >/dev/null 2>&1; }

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
  local d
  d="$default"
  read -rp "$msg [$d] (y/n): " val
  val="${val:-$d}"
  case "$val" in
    y|Y) printf -v "$var" 'y' ;;
    n|N) printf -v "$var" 'n' ;;
    *) warn "Invalid input, using default: $d"; printf -v "$var" "$d" ;;
  esac
}

sudo_keepalive() {
  if ! sudo -n true 2>/dev/null; then
    log "Requesting sudo..."
    sudo -v
  fi
  # keep alive
  ( while true; do sudo -n true; sleep 30; done ) >/dev/null 2>&1 &
  SUDO_KA_PID=$!
  trap 'kill ${SUDO_KA_PID:-0} >/dev/null 2>&1 || true' EXIT
}

kubectl_k3s() { sudo k3s kubectl "$@"; }

wait_pods_ready() {
  local ns="$1" timeout="${2:-300}"
  log "Waiting for pods in namespace '$ns' to be Ready (timeout ${timeout}s)..."
  local start now
  start="$(date +%s)"
  while true; do
    if kubectl_k3s get pods -n "$ns" >/dev/null 2>&1; then
      # Ready if all pods are Running/Completed and Ready condition satisfied where applicable
      local not_ready
      not_ready="$(kubectl_k3s get pods -n "$ns" --no-headers 2>/dev/null | awk '
        {status=$3}
        status!="Running" && status!="Completed" {print; next}
      ')"
      # also check readiness for running pods
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

apply_if_missing() {
  local kind="$1" name="$2" ns="${3:-}"
  if [[ -n "$ns" ]]; then
    kubectl_k3s get "$kind" "$name" -n "$ns" >/dev/null 2>&1 && return 0
  else
    kubectl_k3s get "$kind" "$name" >/dev/null 2>&1 && return 0
  fi
  return 1
}

main() {
  sudo_keepalive

  log "Interactive bootstrap: k3s + Rancher + Longhorn + Registry (Ubuntu)"

  # --- Basics / defaults
  local DEFAULT_DOMAIN="example.local"
  local DEFAULT_RANCHER_HOST="rancher.${DEFAULT_DOMAIN}"
  local DEFAULT_REGISTRY_HOST="registry.${DEFAULT_DOMAIN}"

  prompt DOMAIN "$DEFAULT_DOMAIN" "Base domain (used to build hostnames)"
  prompt RANCHER_HOST "rancher.${DOMAIN}" "Rancher hostname (DNS name)"
  prompt REGISTRY_HOST "registry.${DOMAIN}" "Registry hostname (DNS name)"

  prompt ADMIN_PASS "admin" "Rancher bootstrap password"
  prompt REGISTRY_SIZE "20Gi" "Registry PVC size"
  prompt LONGHORN_REPLICA_COUNT "1" "Longhorn default replica count (1 for single-node)"

  # TLS choice
  echo
  echo "TLS options:"
  echo "  1) Let's Encrypt (requires public DNS + inbound 80/443)"
  echo "  2) Self-signed (works anywhere; you'll need to trust certs in browser/docker)"
  local TLS_CHOICE
  prompt TLS_CHOICE "2" "Choose TLS mode (1/2)"

  local LE_EMAIL="you@example.com"
  local LE_ENV="staging"
  if [[ "$TLS_CHOICE" == "1" ]]; then
    prompt LE_EMAIL "$LE_EMAIL" "Let's Encrypt email"
    prompt LE_ENV "$LE_ENV" "Let's Encrypt environment (staging/production)"
  fi

  # Longhorn data path + optional disk setup
  echo
  prompt LONGHORN_DATA_PATH "/data" "Longhorn data mount path"
  local SETUP_DISK="n"
  prompt_yesno SETUP_DISK "n" "Do you want this script to format+mount a block device to ${LONGHORN_DATA_PATH}?"
  local DISK_DEV=""
  if [[ "$SETUP_DISK" == "y" ]]; then
    prompt DISK_DEV "/dev/sdb" "Block device (DANGER: will be formatted!)"
    warn "You chose to FORMAT ${DISK_DEV} and mount to ${LONGHORN_DATA_PATH}."
    local CONFIRM="n"
    prompt_yesno CONFIRM "n" "Confirm formatting ${DISK_DEV} (this will destroy data)"
    if [[ "$CONFIRM" != "y" ]]; then
      err "Aborted by user."
      exit 1
    fi
  fi

  # --- OS deps
  log "Installing OS dependencies..."
  sudo apt-get update -y
  sudo apt-get install -y curl ca-certificates gnupg lsb-release jq open-iscsi
  sudo systemctl enable --now iscsid

  # --- Optional disk format/mount
  if [[ "$SETUP_DISK" == "y" ]]; then
    log "Formatting ${DISK_DEV} as ext4 and mounting at ${LONGHORN_DATA_PATH}..."
    sudo mkfs.ext4 -F "$DISK_DEV"
    sudo mkdir -p "$LONGHORN_DATA_PATH"
    sudo mount "$DISK_DEV" "$LONGHORN_DATA_PATH"

    # Persist in fstab (simple /dev/ path; you can switch to UUID later if you prefer)
    if ! grep -qE "^[^#]*\s+${LONGHORN_DATA_PATH}\s+" /etc/fstab; then
      log "Persisting mount in /etc/fstab..."
      echo "${DISK_DEV}  ${LONGHORN_DATA_PATH}  ext4  defaults  0  2" | sudo tee -a /etc/fstab >/dev/null
    else
      warn "/etc/fstab already has an entry for ${LONGHORN_DATA_PATH}; skipping."
    fi
    sudo mount -a
  else
    # ensure path exists (even if not separate disk)
    sudo mkdir -p "$LONGHORN_DATA_PATH"
  fi

  # --- Install k3s
  if systemctl is-active --quiet k3s; then
    warn "k3s service already running. Skipping install."
  else
    log "Installing k3s (stable channel)..."
    curl -sfL https://get.k3s.io | sh -
  fi

  log "Checking k3s node..."
  kubectl_k3s get nodes -o wide

  # --- Install Helm
  if ! need_cmd helm; then
    log "Installing Helm..."
    curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
  else
    log "Helm already installed."
  fi

  # Use k3s kubeconfig for helm/kubectl (without needing to copy files)
  export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

  # --- cert-manager
  log "Installing cert-manager..."
  kubectl_k3s create namespace cert-manager >/dev/null 2>&1 || true
  kubectl_k3s apply -f https://github.com/cert-manager/cert-manager/releases/latest/download/cert-manager.yaml
  wait_pods_ready "cert-manager" 420

  # --- Issuer / ClusterIssuer
  log "Configuring certificate issuer..."
  if [[ "$TLS_CHOICE" == "1" ]]; then
    # Let's Encrypt ClusterIssuer (HTTP-01) using Traefik ingress class.
    # If you use another ingress class, change: ingressClassName / annotations.
    cat <<EOF | kubectl_k3s apply -f -
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-${LE_ENV}
spec:
  acme:
    email: ${LE_EMAIL}
    server: $( [[ "$LE_ENV" == "production" ]] && echo "https://acme-v02.api.letsencrypt.org/directory" || echo "https://acme-staging-v02.api.letsencrypt.org/directory" )
    privateKeySecretRef:
      name: letsencrypt-${LE_ENV}-account-key
    solvers:
    - http01:
        ingress:
          ingressClassName: traefik
EOF
    ISSUER_NAME="letsencrypt-${LE_ENV}"
  else
    # Self-signed ClusterIssuer
    cat <<EOF | kubectl_k3s apply -f -
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: selfsigned
spec:
  selfSigned: {}
EOF
    ISSUER_NAME="selfsigned"
  fi

  # --- Install Longhorn
  log "Installing Longhorn..."
  helm repo add longhorn https://charts.longhorn.io >/dev/null 2>&1 || true
  helm repo update >/dev/null

  kubectl_k3s create namespace longhorn-system >/dev/null 2>&1 || true

  # Longhorn: set default replica count + default data path
  # NOTE: Longhorn still needs the disk registered in UI or via node disk config.
  # We'll add a node disk entry post-install via Longhorn's node CRs (simple approach below).
  helm upgrade --install longhorn longhorn/longhorn \
    --namespace longhorn-system \
    --set defaultSettings.defaultReplicaCount="${LONGHORN_REPLICA_COUNT}" \
    --set defaultSettings.defaultDataPath="${LONGHORN_DATA_PATH}"

  wait_pods_ready "longhorn-system" 600

  # Make Longhorn default StorageClass (optional, but practical)
  local MAKE_DEFAULT_SC="y"
  prompt_yesno MAKE_DEFAULT_SC "y" "Make Longhorn the default StorageClass?"
  if [[ "$MAKE_DEFAULT_SC" == "y" ]]; then
    if kubectl_k3s get storageclass longhorn >/dev/null 2>&1; then
      kubectl_k3s patch storageclass longhorn -p '{"metadata":{"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}' >/dev/null || true
    else
      warn "StorageClass 'longhorn' not found yet; you can set it later."
    fi
  fi

  # --- Install Rancher
  log "Installing Rancher..."
  helm repo add rancher-latest https://releases.rancher.com/server-charts/latest >/dev/null 2>&1 || true
  helm repo update >/dev/null

  kubectl_k3s create namespace cattle-system >/dev/null 2>&1 || true

  # Rancher install:
  # - If Let's Encrypt: we let Rancher chart request LE via cert-manager settings (common pattern)
  # - If Self-signed: we create a Certificate ourselves and point Rancher to use the secret
  #
  # IMPORTANT: Hostname must resolve to this VM for ingress routing (edit /etc/hosts or real DNS).
  if [[ "$TLS_CHOICE" == "1" ]]; then
    # Common Rancher chart options for Let's Encrypt
    helm upgrade --install rancher rancher-latest/rancher \
      --namespace cattle-system \
      --set hostname="${RANCHER_HOST}" \
      --set bootstrapPassword="${ADMIN_PASS}" \
      --set ingress.tls.source=letsEncrypt \
      --set letsEncrypt.email="${LE_EMAIL}" \
      --set letsEncrypt.environment="${LE_ENV}"
  else
    # Self-signed: create cert secret with cert-manager, then tell rancher to use it.
    cat <<EOF | kubectl_k3s apply -f -
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: rancher-tls
  namespace: cattle-system
spec:
  secretName: rancher-tls
  issuerRef:
    name: ${ISSUER_NAME}
    kind: ClusterIssuer
  dnsNames:
  - ${RANCHER_HOST}
EOF

    # Wait a bit for secret
    log "Waiting for Rancher TLS secret to be issued..."
    for i in {1..60}; do
      kubectl_k3s get secret rancher-tls -n cattle-system >/dev/null 2>&1 && break
      sleep 2
    done

    helm upgrade --install rancher rancher-latest/rancher \
      --namespace cattle-system \
      --set hostname="${RANCHER_HOST}" \
      --set bootstrapPassword="${ADMIN_PASS}" \
      --set ingress.tls.source=secret \
      --set privateCA=true
  fi

  # Wait Rancher rollout
  log "Waiting for Rancher deployment..."
  kubectl_k3s -n cattle-system rollout status deploy/rancher --timeout=10m || true
  kubectl_k3s get pods -n cattle-system -o wide || true

  # --- Install Docker Registry (in-cluster)
  log "Installing in-cluster Docker Registry (twuni/docker-registry Helm chart)..."
  helm repo add twuni https://helm.twun.io >/dev/null 2>&1 || true
  helm repo update >/dev/null

  kubectl_k3s create namespace registry >/dev/null 2>&1 || true

  # Create TLS cert for registry hostname
  if [[ "$TLS_CHOICE" == "2" ]]; then
    cat <<EOF | kubectl_k3s apply -f -
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: registry-tls
  namespace: registry
spec:
  secretName: registry-tls
  issuerRef:
    name: ${ISSUER_NAME}
    kind: ClusterIssuer
  dnsNames:
  - ${REGISTRY_HOST}
EOF
  fi

  # Install chart with:
  # - persistence on Longhorn
  # - ingress enabled
  # - TLS secret (for LE we'll rely on ingress annotations to request cert)
  #
  # NOTE: Depending on chart version, keys may differ slightly. These are the common ones.
  # If helm complains, run: `helm show values twuni/docker-registry | less` and adjust.
  if [[ "$TLS_CHOICE" == "1" ]]; then
    helm upgrade --install registry twuni/docker-registry \
      --namespace registry \
      --set persistence.enabled=true \
      --set persistence.size="${REGISTRY_SIZE}" \
      --set persistence.storageClass=longhorn \
      --set ingress.enabled=true \
      --set ingress.hosts[0]="${REGISTRY_HOST}" \
      --set ingress.annotations."cert-manager\.io/cluster-issuer"="${ISSUER_NAME}" \
      --set ingress.tls[0].hosts[0]="${REGISTRY_HOST}" \
      --set ingress.tls[0].secretName="registry-tls"
  else
    # self-signed: we already create secret 'registry-tls' via cert-manager
    helm upgrade --install registry twuni/docker-registry \
      --namespace registry \
      --set persistence.enabled=true \
      --set persistence.size="${REGISTRY_SIZE}" \
      --set persistence.storageClass=longhorn \
      --set ingress.enabled=true \
      --set ingress.hosts[0]="${REGISTRY_HOST}" \
      --set ingress.tls[0].hosts[0]="${REGISTRY_HOST}" \
      --set ingress.tls[0].secretName="registry-tls"
  fi

  wait_pods_ready "registry" 300

  # --- Summary / Next steps
  echo
  log "DONE. Quick checks:"
  echo "  k3s nodes:            sudo k3s kubectl get nodes"
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
    echo "  - If you prefer 'insecure registry' instead, that's a different setup (HTTP or skip verify)."
  else
    log "Let's Encrypt TLS:"
    echo "  - Make sure ports 80/443 are reachable from the internet and DNS points to this VM."
    echo "  - If cert issuance fails, check: kubectl describe certificate -A and ingress events."
  fi

  echo
  log "Rancher URL:"
  echo "  https://${RANCHER_HOST}"
  echo "  (bootstrap password: ${ADMIN_PASS})"
  echo
  log "Registry URL:"
  echo "  https://${REGISTRY_HOST}"
  echo
  warn "Registry usage note:"
  echo "  Kubernetes nodes will pull images from the registry using that hostname."
  echo "  If you're building images locally and pushing from the same VM, configure Docker trust accordingly."
}

main "$@"
