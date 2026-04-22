#!/usr/bin/env bash
set -euo pipefail

k() {
  sudo k3s kubectl "$@"
}

main() {
  echo "== Namespace =="
  k get ns longhorn-system
  echo
  echo "== Pods =="
  k get pods -n longhorn-system -o wide
  echo
  echo "== Services =="
  k get svc -n longhorn-system
  echo
  echo "== StorageClasses =="
  k get sc
  echo
  echo "== Longhorn volumes =="
  k get volumes.longhorn.io -n longhorn-system 2>/dev/null || true
  echo
  echo "== Longhorn settings =="
  k get settings.longhorn.io -n longhorn-system 2>/dev/null || true
}

main "$@"
