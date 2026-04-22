#!/usr/bin/env bash
set -euo pipefail

IMAGE_TAG="productive-k3s:test"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

usage() {
  cat <<'EOU'
Usage:
  ./tests/test-in-docker.sh [--image-tag <tag>]

What it does:
  - build the test image
  - run bootstrap in --dry-run mode inside the container

Notes:
  - This is a containerized smoke harness, not a Docker build-time install.
  - It validates the bootstrap flow, prompts, dry-run behavior, and run manifest generation.
  - It does not perform a real k3s installation inside the container.
EOU
}

parse_args() {
  while (($# > 0)); do
    case "$1" in
      --image-tag)
        IMAGE_TAG="${2:-}"
        shift
        ;;
      -h|--help)
        usage
        exit 0
        ;;
      *)
        echo "Unknown argument: $1" >&2
        usage
        exit 1
        ;;
    esac
    shift
  done
}

need_cmd() {
  command -v "$1" >/dev/null 2>&1
}

run_smoke() {
  local answers
  answers=$'y\ny\nn\nn\nn\nn\ny\nn\ny\n'
  printf '%s' "$answers" | docker run --rm -i "$IMAGE_TAG" bash -lc 'cd /workspace && ./scripts/bootstrap-k3s-stack.sh --dry-run'
}

main() {
  parse_args "$@"

  need_cmd docker || { echo "docker is required" >&2; exit 1; }

  echo "[INFO] Building test image: $IMAGE_TAG"
  cd "$REPO_DIR"
  docker build -f tests/Dockerfile.test -t "$IMAGE_TAG" .

  echo "[INFO] Running smoke test"
  run_smoke

  echo "[INFO] Container test completed successfully"
}

main "$@"
