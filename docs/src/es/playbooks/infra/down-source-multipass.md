<!-- generated: playbooks-export-mkdocs -->
# Down Source Multipass

Destroy the source-based `multipass` scenario VMs through the sibling `productive-k3s-profiles` checkout.

## Comando directo del repositorio

```bash
cd productive-k3s-profiles/scenarios/local/multipass
make down
```

## Vista del cast

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/infra/down-source-multipass.cast" data-cast-title="Down Source Multipass">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/infra/down-source-multipass.cast">Abrir cast crudo</a>
  </div>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-infra)
- [Abrir cast crudo](../../../assets/playbooks/casts/infra/down-source-multipass.cast)

## Detalle del escenario

Destroy the source-based `multipass` scenario VMs through the sibling `productive-k3s-profiles` checkout.

Use this when you want the source-oriented scenario teardown instead of the package-first `profile destroy` surface.
