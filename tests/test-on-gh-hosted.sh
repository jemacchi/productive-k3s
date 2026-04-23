#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
ARTIFACTS_DIR="${REPO_DIR}/test-artifacts"
SUMMARY_JSON="${ARTIFACTS_DIR}/hosted-validation-summary.json"
HOST_DRY_RUN_LOG="${ARTIFACTS_DIR}/hosted-bootstrap-dry-run.log"
DOCKER_SMOKE_LOG="${ARTIFACTS_DIR}/docker-smoke.log"
RUN_TIMESTAMP="$(date +%Y%m%d-%H%M%S)"

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

write_summary() {
  local status="$1"
  local host_manifest="$2"
  cat > "$SUMMARY_JSON" <<EOF
{
  "test_type": "github-hosted",
  "runner_os": "ubuntu-24.04",
  "timestamp": "${RUN_TIMESTAMP}",
  "status": "$(json_escape "$status")",
  "checks": {
    "shell_syntax": "success",
    "docker_smoke": "success",
    "host_dry_run": "success"
  },
  "artifacts": {
    "docker_smoke_log": "$(json_escape "$DOCKER_SMOKE_LOG")",
    "host_dry_run_log": "$(json_escape "$HOST_DRY_RUN_LOG")",
    "host_dry_run_manifest": "$(json_escape "$host_manifest")"
  }
}
EOF
}

main() {
  mkdir -p "$ARTIFACTS_DIR"

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
  ./tests/test-in-docker.sh | tee "$DOCKER_SMOKE_LOG"

  echo "[INFO] Running hosted bootstrap dry-run on ubuntu-24.04"
  local answers
  answers=$'y\ny\nn\nn\nn\nn\ny\nn\ny\n'
  printf '%s' "$answers" | ./scripts/bootstrap-k3s-stack.sh --dry-run | tee "$HOST_DRY_RUN_LOG"

  local manifest_path=""
  manifest_path="$(latest_run_manifest || true)"
  if [[ -n "$manifest_path" ]]; then
    cp "$manifest_path" "${ARTIFACTS_DIR}/$(basename "$manifest_path")"
  fi

  write_summary "success" "$manifest_path"
  echo "[INFO] Hosted validation completed successfully"
  echo "[INFO] Summary written to: $SUMMARY_JSON"
}

main "$@"
