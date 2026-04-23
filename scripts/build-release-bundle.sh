#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  ./scripts/build-release-bundle.sh <tag> <output-dir>

Example:
  ./scripts/build-release-bundle.sh v1.2.3 dist
EOF
}

if [[ $# -ne 2 ]]; then
  usage >&2
  exit 1
fi

TAG="$1"
OUTPUT_DIR="$2"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ARCHIVE_NAME="productive-k3s-${TAG}.tar.gz"
PREFIX="productive-k3s-${TAG}/"

mkdir -p "$OUTPUT_DIR"

git -C "$REPO_ROOT" rev-parse --verify "${TAG}^{tag}" >/dev/null 2>&1 || \
git -C "$REPO_ROOT" rev-parse --verify "${TAG}^{commit}" >/dev/null 2>&1 || {
  echo "Tag or ref not found: $TAG" >&2
  exit 1
}

git -C "$REPO_ROOT" archive \
  --format=tar.gz \
  --prefix="$PREFIX" \
  -o "${OUTPUT_DIR}/${ARCHIVE_NAME}" \
  "$TAG"

printf '%s\n' "${OUTPUT_DIR}/${ARCHIVE_NAME}"
