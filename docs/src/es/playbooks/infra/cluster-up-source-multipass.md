<!-- generated: playbooks-export-mkdocs -->
# Cluster Up Source Multipass

Run the source-based `multipass` cluster bootstrap phase from the sibling `productive-k3s-profiles` checkout.

## Comando directo del repositorio

```bash
cd productive-k3s-profiles/scenarios/local/multipass
make cluster-up
```

## Vista del cast

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/infra/cluster-up-source-multipass.cast" data-cast-title="Cluster Up Source Multipass">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/infra/cluster-up-source-multipass.cast">Abrir cast crudo</a>
  </div>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-infra)
- [Abrir cast crudo](../../../assets/playbooks/casts/infra/cluster-up-source-multipass.cast)

## Detalle del escenario

Run the source-based `multipass` cluster bootstrap phase from the sibling `productive-k3s-profiles` checkout.

Use this when the VMs already exist and you want to exercise the scenario-side `productive-k3s-core` bootstrap flow without recreating infrastructure first.
