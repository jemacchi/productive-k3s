#!/usr/bin/env bash
set -euo pipefail

k() {
  sudo k3s kubectl "$@"
}

main() {
  echo "== Traefik service =="
  k get svc -n kube-system traefik
  echo
  k describe svc -n kube-system traefik
  echo
  echo "== Ingress classes =="
  k get ingressclass || true
  echo
  echo "== All ingress resources =="
  k get ingress -A
  echo
  echo "== Detailed ingress rules =="
  k get ingress -A -o json | jq -r '
    .items[]
    | . as $ing
    | [
        ($ing.metadata.namespace + "/" + $ing.metadata.name),
        ("  class: " + ($ing.spec.ingressClassName // "<default>")),
        ("  address: " + ((($ing.status.loadBalancer.ingress // [])
          | map(.ip // .hostname // "<pending>")
          | join(", ")) // "")),
        ("  hosts: " + ((($ing.spec.rules // [])
          | map(.host // "<no-host>")
          | join(", ")) // "<none>")),
        ("  tls: " + (
          if (($ing.spec.tls // []) | length) == 0 then
            "<none>"
          else
            (($ing.spec.tls // [])
              | map(
                  "secret=" + (.secretName // "<none>") +
                  " hosts=[" + ((.hosts // []) | join(", ")) + "]"
                )
              | join("; "))
          end
        )),
        ("  backends: " + (
          if (($ing.spec.rules // []) | length) == 0 then
            "<none>"
          else
            (($ing.spec.rules // [])
              | map(
                  ((.host // "<no-host>") + " => " +
                  ((.http.paths // [])
                    | map(
                        (.path // "/") + " -> " +
                        (.backend.service.name // "<no-service>") + ":" +
                        ((.backend.service.port.number // .backend.service.port.name // "<no-port>") | tostring)
                      )
                    | join(", ")))
                )
              | join("; "))
          end
        )),
        ("  annotations:")
      ] + (
        (($ing.metadata.annotations // {}) | to_entries | sort_by(.key))
        | if length == 0 then
            ["    <none>"]
          else
            map("    " + .key + "=" + .value)
          end
      ) + [""]
    | .[]
  '
}

main "$@"
