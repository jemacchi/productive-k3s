<!-- generated: playbooks-export-mkdocs -->
# Live Catalog Multipass

Run the live catalog-backed `multipass` lifecycle through the CLI validator.

## Comando directo del repositorio

```bash
cd productive-k3s-cli
bash ./tests/live-cli-catalog-multipass.sh
```

## Vista del cast

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/cli/live-catalog-multipass.cast" data-cast-title="Live Catalog Multipass">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/cli/live-catalog-multipass.cast">Abrir cast crudo</a>
  </div>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-cli)
- [Abrir cast crudo](../../../assets/playbooks/casts/cli/live-catalog-multipass.cast)

## Detalle del escenario

Run the live catalog-backed `multipass` lifecycle through the CLI validator.

Use this when you want a real end-to-end proof of:

- catalog-backed profile validation
- package-first infra install and status
- catalog-backed addon validation and install
- cleanup through the published operator surface

The wrapper defaults to the local sibling `core`, `infra`, `profiles`, and `addons` checkouts on `development` and assigns a unique `PK3S_CLI_MULTIPASS_CLUSTER_PREFIX` unless you override it.

Run this only when `multipass` and the required local prerequisites are available.
