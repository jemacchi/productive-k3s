<!-- generated: playbooks-export-mkdocs -->
# Core Command Mapping Review

Review the expected CLI-to-Core command delegation map.

## Comando directo del repositorio

```bash
cd productive-k3s-cli
bash -lc 'tmp="$(mktemp -d)"; trap '"'"'"'"'"'"'"'"'rm -rf "$tmp"'"'"'"'"'"'"'"'"' EXIT; TEST_ARTIFACTS_DIR="$tmp" bash ./tests/contracts/03-core-command-mapping-contract.sh && cat "$tmp/core-command-mapping-contract.json"'
```

## Vista del cast

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/cli/core-command-mapping-review.cast" data-cast-title="Core Command Mapping Review">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/cli/core-command-mapping-review.cast">Abrir cast crudo</a>
  </div>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-cli)
- [Abrir cast crudo](../../../assets/playbooks/casts/cli/core-command-mapping-review.cast)

## Detalle del escenario

Review the expected CLI-to-Core command delegation map.

Use this when you want to show:

- which user-facing `pk3s` commands delegate into `productive-k3s-core.sh`
- that the contract is reviewed from a generated artifact, not by hand
- the expected bundle-info, addon, stack, install, validate, and backup mappings
