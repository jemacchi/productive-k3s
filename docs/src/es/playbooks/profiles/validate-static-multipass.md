<!-- generated: playbooks-export-mkdocs -->
# Validate Static Multipass

Run the `multipass` static validation path from the `productive-k3s-profiles` source checkout.

## Comando directo del repositorio

```bash
cd productive-k3s-profiles
SCENARIO=multipass PRODUCTIVE_K3S_INFRA_REPO_DIR=../productive-k3s-infra bash ./scripts/productive-k3s-profiles-dev.sh test-static
```

## Vista del cast

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/profiles/validate-static-multipass.cast" data-cast-title="Validate Static Multipass">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/profiles/validate-static-multipass.cast">Abrir cast crudo</a>
  </div>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-profiles)
- [Abrir cast crudo](../../../assets/playbooks/casts/profiles/validate-static-multipass.cast)

## Detalle del escenario

Run the `multipass` static validation path from the `productive-k3s-profiles` source checkout.

Use this when you want the shortest meaningful proof that the local multi-node scenario still validates against the current Infra development surface.
