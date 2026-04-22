#!/usr/bin/env bash
set -euo pipefail

k() {
  sudo k3s kubectl "$@"
}

main() {
  echo "== Namespace =="
  k get ns cattle-system
  echo
  echo "== Pods =="
  k get pods -n cattle-system -o wide
  echo
  echo "== Deployments =="
  k get deploy -n cattle-system
  echo
  echo "== Services =="
  k get svc -n cattle-system
  echo
  echo "== Ingress =="
  k get ingress -n cattle-system
  echo
  echo "== Certificates and Secrets =="
  k get certificate -n cattle-system 2>/dev/null || true
  k get secret -n cattle-system | grep -E 'tls|bootstrap|ca' || true
  echo
  echo "== Rollout =="
  k rollout status deploy/rancher -n cattle-system --timeout=30s || true
  echo
  echo "== HTTPS probe =="
  curl -kI https://rancher.home.arpa || true
}

main "$@"
