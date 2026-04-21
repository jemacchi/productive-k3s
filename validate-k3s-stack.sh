#!/usr/bin/env bash
set -uo pipefail

STRICT=0
JSON_OUTPUT=0
DOCKER_REGISTRY_TEST=0
FAILURES=0
WARNINGS=0
CHECK_RESULTS=()

json_escape() {
  local s="$1"
  s="${s//\\/\\\\}"
  s="${s//\"/\\\"}"
  s="${s//$'\n'/\\n}"
  s="${s//$'\r'/\\r}"
  s="${s//$'\t'/\\t}"
  printf '%s' "$s"
}

append_result() {
  local level="$1" message="$2"
  CHECK_RESULTS+=("{\"level\":\"$(json_escape "$level")\",\"message\":\"$(json_escape "$message")\"}")
}

ok() {
  append_result "ok" "$1"
  if [[ "$JSON_OUTPUT" == "0" ]]; then
    printf "\033[1;32m[OK]\033[0m %s\n" "$1"
  fi
}

warn() {
  append_result "warn" "$1"
  if [[ "$JSON_OUTPUT" == "0" ]]; then
    printf "\033[1;33m[WARN]\033[0m %s\n" "$1"
  fi
}

fail() {
  append_result "fail" "$1"
  if [[ "$JSON_OUTPUT" == "0" ]]; then
    printf "\033[1;31m[FAIL]\033[0m %s\n" "$1"
  fi
}

info() {
  append_result "info" "$1"
  if [[ "$JSON_OUTPUT" == "0" ]]; then
    printf "\n\033[1;34m[INFO]\033[0m %s\n" "$1"
  fi
}

parse_args() {
  while (($# > 0)); do
    case "$1" in
      --strict)
        STRICT=1
        ;;
      --json)
        JSON_OUTPUT=1
        ;;
      -h|--help)
        cat <<EOF
Usage: $0 [--strict] [--json] [--docker-registry-test]

  --strict   Exit non-zero on warnings as well as failures
  --json     Emit machine-readable JSON instead of human-readable output
  --docker-registry-test
             Run docker push/pull validation against registry.home.arpa
             If REGISTRY_USER and REGISTRY_PASSWORD are set, it also validates docker login
EOF
        exit 0
        ;;
      --docker-registry-test)
        DOCKER_REGISTRY_TEST=1
        ;;
      *)
        printf 'Unknown argument: %s\n' "$1" >&2
        exit 2
        ;;
    esac
    shift
  done
}

need_cmd() {
  command -v "$1" >/dev/null 2>&1
}

record_ok() {
  ok "$1"
}

record_warn() {
  WARNINGS=$((WARNINGS + 1))
  warn "$1"
}

record_fail() {
  FAILURES=$((FAILURES + 1))
  fail "$1"
}

sudo_keepalive() {
  if ! sudo -n true 2>/dev/null; then
    info "Requesting sudo"
    sudo -v || {
      record_fail "sudo authentication failed"
      exit 1
    }
  fi
  ( while true; do sudo -n true; sleep 30; done ) >/dev/null 2>&1 &
  SUDO_KA_PID=$!
  trap 'kill ${SUDO_KA_PID:-0} >/dev/null 2>&1 || true' EXIT
}

k() {
  sudo k3s kubectl "$@"
}

safe_run() {
  local output
  if ! output="$("$@" 2>&1)"; then
    printf '%s' "$output"
    return 1
  fi
  printf '%s' "$output"
}

check_cmds() {
  info "Checking required commands"
  local missing=()
  local cmd
  for cmd in sudo k3s kubectl curl getent; do
    if ! need_cmd "$cmd"; then
      missing+=("$cmd")
    fi
  done

  if ((${#missing[@]} > 0)); then
    record_fail "missing required commands: ${missing[*]}"
  else
    record_ok "required commands are available"
  fi

  if (( DOCKER_REGISTRY_TEST == 1 )); then
    if need_cmd docker; then
      record_ok "docker is available for registry functional validation"
    else
      record_fail "docker is required for --docker-registry-test"
    fi
  fi
}

check_k3s_service() {
  info "Checking k3s service"
  if sudo systemctl is-active --quiet k3s; then
    record_ok "k3s service is active"
  else
    record_fail "k3s service is not active"
  fi
}

check_nodes() {
  info "Checking cluster nodes"
  local nodes statuses
  if ! nodes="$(safe_run k get nodes -o wide)"; then
    record_fail "unable to query cluster nodes"
    return
  fi

  statuses="$(printf '%s\n' "$nodes" | awk 'NR>1 {print $2}')"
  if [[ -z "$statuses" ]]; then
    record_fail "cluster returned no nodes"
    return
  fi

  if printf '%s\n' "$statuses" | grep -qv '^Ready$'; then
    record_fail "one or more nodes are not Ready"
    printf '%s\n' "$nodes"
  else
    record_ok "all nodes are Ready"
  fi
}

check_all_pods() {
  info "Checking all pods"
  local pods bad
  if ! pods="$(safe_run k get pods -A -o wide)"; then
    record_fail "unable to list pods"
    return
  fi

  bad="$(printf '%s\n' "$pods" | awk '
    NR==1 {next}
    {
      ready=$3
      status=$4
      split(ready,a,"/")
      if (status != "Running" && status != "Completed") print
      else if (status == "Running" && a[1] != a[2]) print
    }
  ')"

  if [[ -n "$bad" ]]; then
    record_fail "there are pods not healthy enough"
    printf '%s\n' "$bad"
  else
    record_ok "all pods are Running or Completed"
  fi
}

check_storage_classes() {
  info "Checking storage classes"
  local sc defaults
  if ! sc="$(safe_run k get sc)"; then
    record_fail "unable to query storage classes"
    return
  fi

  defaults="$(printf '%s\n' "$sc" | awk 'NR>1 && $1 ~ /\(default\)$/ {count++} END {print count+0}')"
  if [[ "$defaults" == "0" ]]; then
    defaults="$(printf '%s\n' "$sc" | grep -c '(default)' || true)"
  fi
  if [[ "$defaults" == "1" ]]; then
    record_ok "exactly one default StorageClass is configured"
  elif [[ "$defaults" == "0" ]]; then
    record_warn "no default StorageClass is configured"
  else
    record_fail "multiple default StorageClasses are configured"
    printf '%s\n' "$sc"
  fi
}

check_ingress() {
  info "Checking ingress resources"
  local ingress
  if ! ingress="$(safe_run k get ingress -A)"; then
    record_fail "unable to query ingress resources"
    return
  fi

  if printf '%s\n' "$ingress" | awk 'NR>1 {print}' | grep -q .; then
    record_ok "ingress resources are present"
  else
    record_warn "no ingress resources found"
  fi
}

check_namespace_rollup() {
  local ns="$1" label="$2"
  info "Checking ${label} namespace"

  if ! k get namespace "$ns" >/dev/null 2>&1; then
    record_warn "namespace '${ns}' does not exist"
    return
  fi

  local pods
  if ! pods="$(safe_run k get pods -n "$ns" -o wide)"; then
    record_fail "unable to query pods in namespace '${ns}'"
    return
  fi

  local bad
  bad="$(printf '%s\n' "$pods" | awk '
    NR==1 {next}
    {
      ready=$2
      status=$3
      split(ready,a,"/")
      if (status != "Running" && status != "Completed") print
      else if (status == "Running" && a[1] != a[2]) print
    }
  ')"

  if [[ -n "$bad" ]]; then
    record_fail "${label} has unhealthy pods"
    printf '%s\n' "$bad"
  else
    record_ok "${label} pods are healthy"
  fi
}

check_cert_manager() {
  info "Checking cert-manager"
  if ! k get namespace cert-manager >/dev/null 2>&1; then
    if k get namespace cattle-system >/dev/null 2>&1 || k get namespace registry >/dev/null 2>&1; then
      record_warn "cert-manager namespace does not exist even though TLS-dependent components are present"
    else
      info "cert-manager is not installed; skipping cert-manager-specific checks"
    fi
    return
  fi

  check_namespace_rollup "cert-manager" "cert-manager"

  local issuers
  if ! issuers="$(safe_run k get clusterissuer 2>/dev/null)"; then
    record_warn "unable to query ClusterIssuers"
    return
  fi

  if printf '%s\n' "$issuers" | awk 'NR>1 {print}' | grep -q .; then
    record_ok "ClusterIssuer resources are present"
  else
    record_warn "no ClusterIssuer resources found"
  fi

  local certs not_ready
  if certs="$(safe_run k get certificates -A 2>/dev/null)"; then
    not_ready="$(printf '%s\n' "$certs" | awk 'NR>1 && $3 != "True" {print}')"
    if [[ -n "$not_ready" ]]; then
      record_warn "some certificates are not Ready"
      printf '%s\n' "$not_ready"
    else
      record_ok "all certificates are Ready"
    fi
  fi
}

check_longhorn() {
  info "Checking Longhorn"
  if ! k get namespace longhorn-system >/dev/null 2>&1; then
    info "Longhorn is not installed; skipping Longhorn-specific checks"
    return
  fi

  check_namespace_rollup "longhorn-system" "Longhorn"

  local volumes
  if volumes="$(safe_run k get volumes.longhorn.io -n longhorn-system 2>/dev/null)"; then
    if printf '%s\n' "$volumes" | awk 'NR>1 {print}' | grep -q .; then
      record_ok "Longhorn volumes API is responding"
    else
      record_ok "Longhorn is installed but no volumes exist yet"
    fi
  fi
}

check_rancher() {
  info "Checking Rancher"
  if ! k get namespace cattle-system >/dev/null 2>&1; then
    info "Rancher is not installed; skipping Rancher-specific checks"
    return
  fi

  check_namespace_rollup "cattle-system" "Rancher"

  if k get secret tls-ca -n cattle-system >/dev/null 2>&1; then
    record_ok "Rancher private CA secret exists"
  else
    record_warn "Rancher private CA secret 'tls-ca' is missing"
  fi

  if k get ingress rancher -n cattle-system >/dev/null 2>&1; then
    record_ok "Rancher ingress exists"
  else
    record_warn "Rancher ingress does not exist"
  fi
}

check_registry() {
  info "Checking in-cluster registry"
  if ! k get namespace registry >/dev/null 2>&1; then
    info "Registry is not installed; skipping registry-specific checks"
    return
  fi

  check_namespace_rollup "registry" "Registry"

  local pvc
  if pvc="$(safe_run k get pvc -n registry 2>/dev/null)"; then
    if printf '%s\n' "$pvc" | awk 'NR>1 && $2 != "Bound" {print}' | grep -q .; then
      record_fail "registry PVC exists but is not Bound"
      printf '%s\n' "$pvc"
    elif printf '%s\n' "$pvc" | awk 'NR>1 {print}' | grep -q .; then
      record_ok "registry PVC is Bound"
    else
      record_warn "no registry PVC found"
    fi
  fi

  if k get ingress registry -n registry >/dev/null 2>&1; then
    record_ok "registry ingress exists"
  else
    record_warn "registry ingress does not exist"
  fi
}

check_dns_and_http() {
  info "Checking local DNS and HTTPS access"
  local rancher_present="n" registry_present="n"
  if k get ingress rancher -n cattle-system >/dev/null 2>&1; then
    rancher_present="y"
  fi
  if k get ingress registry -n registry >/dev/null 2>&1; then
    registry_present="y"
  fi

  if [[ "$rancher_present" == "y" ]]; then
    if getent hosts rancher.home.arpa >/dev/null 2>&1; then
      record_ok "rancher.home.arpa resolves locally"
    else
      record_warn "rancher.home.arpa does not resolve locally"
    fi
    local rancher_code
    rancher_code="$(curl -k -s -o /dev/null -w '%{http_code}' --max-time 10 https://rancher.home.arpa || true)"
    if [[ "$rancher_code" =~ ^(200|302|401|403)$ ]]; then
      record_ok "Rancher HTTPS endpoint responds with HTTP ${rancher_code}"
    else
      record_warn "Rancher HTTPS endpoint did not return an expected code (got '${rancher_code:-none}')"
    fi
  else
    info "Rancher ingress is not present; skipping Rancher DNS/HTTPS checks"
  fi

  if [[ "$registry_present" == "y" ]]; then
    if getent hosts registry.home.arpa >/dev/null 2>&1; then
      record_ok "registry.home.arpa resolves locally"
    else
      record_warn "registry.home.arpa does not resolve locally"
    fi
    local registry_code
    registry_code="$(curl -k -s -o /dev/null -w '%{http_code}' --max-time 10 https://registry.home.arpa/v2/ || true)"
    if [[ "$registry_code" =~ ^(200|401)$ ]]; then
      record_ok "Registry HTTPS endpoint responds with HTTP ${registry_code}"
    else
      record_warn "Registry HTTPS endpoint did not return an expected code (got '${registry_code:-none}')"
    fi
  else
    info "Registry ingress is not present; skipping Registry DNS/HTTPS checks"
  fi
}

check_nfs() {
  info "Checking NFS exports"
  local service_name="nfs-kernel-server"
  if systemctl list-unit-files nfs-server.service >/dev/null 2>&1; then
    service_name="nfs-server"
  fi

  if sudo systemctl is-active --quiet "$service_name"; then
    record_ok "NFS service '${service_name}' is active"
  else
    record_warn "NFS service '${service_name}' is not active"
  fi

  local exports
  if ! exports="$(safe_run sudo exportfs -v)"; then
    record_warn "unable to query NFS exports"
    return
  fi

  if printf '%s\n' "$exports" | grep -q '^/srv/nfs/k8s-share'; then
    record_ok "expected NFS export '/srv/nfs/k8s-share' is present"
  else
    record_warn "expected NFS export '/srv/nfs/k8s-share' is not present"
  fi
}

check_docker_registry_flow() {
  (( DOCKER_REGISTRY_TEST == 1 )) || return 0

  info "Checking registry with docker push/pull"

  if ! need_cmd docker; then
    record_fail "docker command is not available"
    return
  fi

  local upstream_image="busybox:1.36"
  local test_image="registry.home.arpa/validate/busybox:1.36"
  local did_login="n"

  if [[ -n "${REGISTRY_USER:-}" || -n "${REGISTRY_PASSWORD:-}" ]]; then
    if [[ -z "${REGISTRY_USER:-}" || -z "${REGISTRY_PASSWORD:-}" ]]; then
      record_fail "set both REGISTRY_USER and REGISTRY_PASSWORD, or neither"
      return
    fi

    if ! printf '%s' "$REGISTRY_PASSWORD" | docker login registry.home.arpa -u "$REGISTRY_USER" --password-stdin >/dev/null 2>&1; then
      record_fail "docker login to registry.home.arpa failed"
      return
    fi

    did_login="y"
    record_ok "docker login to registry.home.arpa succeeded"
  fi

  if ! docker pull "$upstream_image" >/dev/null 2>&1; then
    record_fail "docker pull ${upstream_image} failed"
    if [[ "$did_login" == "y" ]]; then
      docker logout registry.home.arpa >/dev/null 2>&1 || true
    fi
    return
  fi

  if ! docker tag "$upstream_image" "$test_image" >/dev/null 2>&1; then
    record_fail "docker tag for registry validation image failed"
    if [[ "$did_login" == "y" ]]; then
      docker logout registry.home.arpa >/dev/null 2>&1 || true
    fi
    return
  fi

  if ! docker push "$test_image" >/dev/null 2>&1; then
    record_fail "docker push to registry.home.arpa failed"
    if [[ "$did_login" == "y" ]]; then
      docker logout registry.home.arpa >/dev/null 2>&1 || true
    fi
    docker image rm -f "$test_image" >/dev/null 2>&1 || true
    return
  fi

  docker image rm -f "$test_image" >/dev/null 2>&1 || true

  if ! docker pull "$test_image" >/dev/null 2>&1; then
    record_fail "docker pull from registry.home.arpa failed after push"
    if [[ "$did_login" == "y" ]]; then
      docker logout registry.home.arpa >/dev/null 2>&1 || true
    fi
    docker image rm -f "$test_image" >/dev/null 2>&1 || true
    return
  fi

  if [[ "$did_login" == "y" ]]; then
    docker logout registry.home.arpa >/dev/null 2>&1 || true
    record_ok "docker push/pull against authenticated registry.home.arpa succeeded"
  else
    record_ok "docker push/pull against anonymous registry.home.arpa succeeded"
  fi
  docker image rm -f "$test_image" >/dev/null 2>&1 || true
}

print_summary() {
  local exit_code=0
  if (( FAILURES > 0 )); then
    exit_code=1
  elif (( STRICT == 1 && WARNINGS > 0 )); then
    exit_code=1
  fi

  if [[ "$JSON_OUTPUT" == "1" ]]; then
    local status="ok"
    if (( FAILURES > 0 )); then
      status="fail"
    elif (( WARNINGS > 0 )); then
      status="warn"
    fi

    printf '{'
    printf '"status":"%s",' "$status"
    printf '"strict":%s,' "$( (( STRICT == 1 )) && echo true || echo false )"
    printf '"failures":%d,' "$FAILURES"
    printf '"warnings":%d,' "$WARNINGS"
    printf '"results":['
    local i
    for i in "${!CHECK_RESULTS[@]}"; do
      [[ "$i" -gt 0 ]] && printf ','
      printf '%s' "${CHECK_RESULTS[$i]}"
    done
    printf ']}\n'
  else
    echo
    info "Validation summary"
    echo "Failures: ${FAILURES}"
    echo "Warnings: ${WARNINGS}"
    if (( STRICT == 1 )); then
      echo "Mode: strict"
    fi
  fi

  exit "$exit_code"
}

main() {
  parse_args "$@"
  sudo_keepalive
  check_cmds
  check_k3s_service
  check_nodes
  check_all_pods
  check_storage_classes
  check_ingress
  check_cert_manager
  check_longhorn
  check_rancher
  check_registry
  check_dns_and_http
  check_nfs
  check_docker_registry_flow
  print_summary
}

main "$@"
