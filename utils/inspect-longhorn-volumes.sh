#!/usr/bin/env bash
set -euo pipefail

k() {
  sudo k3s kubectl "$@"
}

main() {
  echo "== StorageClasses =="
  k get sc
  echo
  echo "== Longhorn volume summary =="
  k get volumes.longhorn.io -n longhorn-system 2>/dev/null || true
  echo
  echo "== PVC summary =="
  k get pvc -A
  echo
  echo "== Longhorn scheduling-related settings =="
  k get settings.longhorn.io -n longhorn-system storage-minimal-available-percentage default-replica-count 2>/dev/null || true
  echo
  echo "== Problematic Longhorn volumes =="
  k get volumes.longhorn.io -n longhorn-system -o json 2>/dev/null | jq -r '
    .items[]
    | select((.status.robustness // "") != "healthy" or (.status.state // "") != "attached")
    | ((.status.conditions // [])
        | map(select((.type // "") == "scheduled") | .status)
        | first // "unknown") as $scheduled
    | [
        .metadata.name,
        "state=" + (.status.state // "unknown"),
        "robustness=" + (.status.robustness // "unknown"),
        "scheduled=" + ($scheduled | tostring),
        "node=" + (.status.currentNodeID // "<none>")
      ]
    | join(" ")
  ' || true
  echo
  echo "== Volume attachments =="
  k get volumeattachments 2>/dev/null || true
}

main "$@"
