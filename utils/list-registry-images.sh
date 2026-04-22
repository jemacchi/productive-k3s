#!/usr/bin/env bash
set -euo pipefail

REGISTRY_HOST="${REGISTRY_HOST:-registry.home.arpa}"
CURL_INSECURE=1
OUTPUT_JSON=0
REGISTRY_USER="${REGISTRY_USER:-}"
REGISTRY_PASSWORD="${REGISTRY_PASSWORD:-}"

usage() {
  cat <<USAGE
Usage: $0 [--host HOST] [--secure] [--json]

Lists repositories and tags from a Docker Registry v2 endpoint.

Options:
  --host HOST   Registry host to query. Default: registry.home.arpa
  --secure      Do not pass -k to curl
  --json        Emit one JSON object per repository with tags

Environment:
  REGISTRY_USER       Optional basic-auth user
  REGISTRY_PASSWORD   Optional basic-auth password
USAGE
}

need_cmd() {
  command -v "$1" >/dev/null 2>&1
}

curl_registry() {
  local path="$1"
  local -a cmd=(curl -fsS)
  if (( CURL_INSECURE == 1 )); then
    cmd+=(-k)
  fi
  if [[ -n "$REGISTRY_USER" || -n "$REGISTRY_PASSWORD" ]]; then
    cmd+=(-u "${REGISTRY_USER}:${REGISTRY_PASSWORD}")
  fi
  cmd+=("https://${REGISTRY_HOST}${path}")
  "${cmd[@]}"
}

parse_args() {
  while (($# > 0)); do
    case "$1" in
      --host)
        REGISTRY_HOST="$2"
        shift
        ;;
      --secure)
        CURL_INSECURE=0
        ;;
      --json)
        OUTPUT_JSON=1
        ;;
      -h|--help)
        usage
        exit 0
        ;;
      *)
        printf 'Unknown argument: %s\n' "$1" >&2
        exit 2
        ;;
    esac
    shift
  done
}

main() {
  parse_args "$@"

  need_cmd curl || { echo "missing command: curl" >&2; exit 1; }
  need_cmd jq || { echo "missing command: jq" >&2; exit 1; }

  local catalog repos repo tags_json
  catalog="$(curl_registry /v2/_catalog)"
  repos="$(printf '%s' "$catalog" | jq -r '.repositories[]?')"

  if [[ -z "$repos" ]]; then
    if (( OUTPUT_JSON == 1 )); then
      printf '{"registry":"%s","repositories":[]}\n' "$REGISTRY_HOST"
    else
      printf 'Registry: %s\n' "$REGISTRY_HOST"
      printf 'Repositories: none\n'
    fi
    return 0
  fi

  if (( OUTPUT_JSON == 0 )); then
    printf 'Registry: %s\n' "$REGISTRY_HOST"
  fi

  while IFS= read -r repo; do
    tags_json="$(curl_registry "/v2/${repo}/tags/list" 2>/dev/null || printf '{\"name\":\"%s\",\"tags\":[]}' "$repo")"
    if (( OUTPUT_JSON == 1 )); then
      printf '%s\n' "$tags_json" | jq -c --arg registry "$REGISTRY_HOST" '. + {registry:$registry}'
    else
      printf '\nRepository: %s\n' "$repo"
      printf '%s\n' "$tags_json" | jq -r 'if (.tags // []) | length > 0 then .tags[] else "<no tags>" end' | sed 's/^/  - /'
    fi
  done <<< "$repos"
}

main "$@"
