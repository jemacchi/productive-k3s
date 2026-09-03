<!-- generated: playbooks-export-mkdocs -->
# Stack Base Registry Checks

Validate registry behavior after `base` is installed.

## Comando directo del repositorio

```bash
bash ./productive-k3s-core.sh validate --strict --docker-registry-test
bash -lc curl\ -kI\ https://registry.home.arpa/v2/
bash -lc curl\ -k\ https://registry.home.arpa/v2/_catalog\ \|\ jq
bash ./utils/list-registry-images.sh --json
```

## Vista del cast

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/core/stack-base-registry-checks.cast" data-cast-title="Stack Base Registry Checks">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/core/stack-base-registry-checks.cast">Abrir cast crudo</a>
  </div>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-core)
- [Abrir cast crudo](../../../assets/playbooks/casts/core/stack-base-registry-checks.cast)

## Detalle del escenario

Validate registry behavior after `base` is installed.

This includes:

- `validate --strict --docker-registry-test`
- registry endpoint probes
- registry inventory helper output
