#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
ARTIFACTS_DIR="${REPO_DIR}/test-artifacts"
SUMMARY_JSON="${ARTIFACTS_DIR}/hosted-validation-summary.json"
HOST_FULL_LOG="${ARTIFACTS_DIR}/hosted-bootstrap-full.log"
HOST_VALIDATE_LOG="${ARTIFACTS_DIR}/hosted-validate-strict.log"
HOST_CLEAN_LOG="${ARTIFACTS_DIR}/hosted-clean.log"
DOCKER_SMOKE_LOG="${ARTIFACTS_DIR}/docker-smoke.log"
RUN_TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
DOCKER_SMOKE_STATUS="not-run"
HOST_BOOTSTRAP_STATUS="not-run"
HOST_VALIDATE_STATUS="not-run"
HOST_CLEAN_STATUS="not-run"
OVERALL_STATUS="failed"
HOST_MANIFEST_PATH=""

need_cmd() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "[ERROR] Missing required command: $1" >&2
    exit 1
  }
}

json_escape() {
  local value="${1:-}"
  value=${value//\\/\\\\}
  value=${value//\"/\\\"}
  value=${value//$'\n'/\\n}
  value=${value//$'\r'/\\r}
  value=${value//$'\t'/\\t}
  printf '%s' "$value"
}

latest_run_manifest() {
  find "${REPO_DIR}/runs" -maxdepth 1 -type f -name 'bootstrap-*.json' 2>/dev/null | sort | tail -n 1
}

copy_latest_manifest() {
  HOST_MANIFEST_PATH="$(latest_run_manifest || true)"
  if [[ -n "$HOST_MANIFEST_PATH" ]]; then
    cp "$HOST_MANIFEST_PATH" "${ARTIFACTS_DIR}/$(basename "$HOST_MANIFEST_PATH")"
  fi
}

write_summary() {
  cat > "$SUMMARY_JSON" <<EOF
{
  "test_type": "github-hosted",
  "runner_os": "ubuntu-24.04",
  "timestamp": "${RUN_TIMESTAMP}",
  "status": "$(json_escape "$OVERALL_STATUS")",
  "checks": {
    "shell_syntax": "success",
    "docker_smoke": "$(json_escape "$DOCKER_SMOKE_STATUS")",
    "host_bootstrap_full": "$(json_escape "$HOST_BOOTSTRAP_STATUS")",
    "host_validate_strict": "$(json_escape "$HOST_VALIDATE_STATUS")",
    "host_clean": "$(json_escape "$HOST_CLEAN_STATUS")"
  },
  "artifacts": {
    "docker_smoke_log": "$(json_escape "$DOCKER_SMOKE_LOG")",
    "host_bootstrap_full_log": "$(json_escape "$HOST_FULL_LOG")",
    "host_validate_strict_log": "$(json_escape "$HOST_VALIDATE_LOG")",
    "host_clean_log": "$(json_escape "$HOST_CLEAN_LOG")",
    "host_manifest": "$(json_escape "$HOST_MANIFEST_PATH")"
  }
}
EOF
}

cleanup_and_write_summary() {
  local exit_code="${1:-0}"
  copy_latest_manifest
  if [[ "$HOST_BOOTSTRAP_STATUS" == "success" && "$HOST_CLEAN_STATUS" == "not-run" ]]; then
    echo "[INFO] Running best-effort cleanup after partial hosted validation"
    local confirm=$'y\nCLEAN\n'
    if printf '%s' "$confirm" | ./scripts/clean-k3s-stack.sh --apply >"$HOST_CLEAN_LOG" 2>&1; then
      HOST_CLEAN_STATUS="success"
    else
      HOST_CLEAN_STATUS="failed"
    fi
  fi
  write_summary
  exit "$exit_code"
}

run_with_log() {
  local log_path="$1"
  shift
  set +e
  "$@" > >(tee "$log_path") 2>&1
  local rc=$?
  set -e
  return "$rc"
}

main() {
  mkdir -p "$ARTIFACTS_DIR"
  trap 'cleanup_and_write_summary $?' EXIT

  need_cmd bash
  need_cmd docker
  need_cmd jq

  cd "$REPO_DIR"

  echo "[INFO] Checking shell syntax"
  bash -n scripts/bootstrap-k3s-stack.sh
  bash -n tests/test-in-docker.sh
  bash -n tests/test-in-vm.sh
  bash -n scripts/rollback-k3s-stack.sh
  bash -n scripts/clean-k3s-stack.sh

  echo "[INFO] Running Docker smoke harness"
  run_with_log "$DOCKER_SMOKE_LOG" bash ./tests/test-in-docker.sh
  DOCKER_SMOKE_STATUS="success"

  echo "[INFO] Running hosted full bootstrap on ubuntu-24.04"
  local answers
  answers=$'y
y
y
y
y
y
y


y
home.arpa





n
2



y
y
y
y
y
y
y
'
  if ! printf '%s' "$answers" | ./scripts/bootstrap-k3s-stack.sh | tee "$HOST_FULL_LOG"; then
    HOST_BOOTSTRAP_STATUS="failed"
    return 1
  fi
  HOST_BOOTSTRAP_STATUS="success"

  copy_latest_manifest

  echo "[INFO] Running strict validation on hosted ubuntu-24.04"
  if ! run_with_log "$HOST_VALIDATE_LOG" bash ./scripts/validate-k3s-stack.sh --strict; then
    HOST_VALIDATE_STATUS="failed"
    return 1
  fi
  HOST_VALIDATE_STATUS="success"

  echo "[INFO] Running destructive cleanup on hosted ubuntu-24.04"
  local confirm=$'y\nCLEAN\n'
  if ! printf '%s' "$confirm" | ./scripts/clean-k3s-stack.sh --apply | tee "$HOST_CLEAN_LOG"; then
    HOST_CLEAN_STATUS="failed"
    return 1
  fi
  HOST_CLEAN_STATUS="success"

  OVERALL_STATUS="success"
  echo "[INFO] Hosted validation completed successfully"
  echo "[INFO] Summary written to: $SUMMARY_JSON"
}

main "$@"
