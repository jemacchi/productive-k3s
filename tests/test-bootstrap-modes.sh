#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

fail() {
  printf '[FAIL] %s\n' "$1" >&2
  exit 1
}

pass() {
  printf '[PASS] %s\n' "$1"
}

help_output="$(cd "$REPO_DIR" && ./scripts/bootstrap-k3s-stack.sh --help)"
printf '%s\n' "$help_output" | grep -q -- '--mode <single-node|server|agent|stack>' || fail "help does not describe --mode"
pass "help documents --mode"

if (cd "$REPO_DIR" && ./scripts/bootstrap-k3s-stack.sh --mode unsupported >/tmp/productive-k3s-invalid-mode.out 2>&1); then
  fail "unsupported mode unexpectedly succeeded"
fi
grep -q "Unsupported mode" /tmp/productive-k3s-invalid-mode.out || fail "unsupported mode error message missing"
pass "unsupported mode is rejected"
