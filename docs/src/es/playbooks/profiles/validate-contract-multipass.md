<!-- generated: playbooks-export-mkdocs -->
# Validate Contract Multipass

Run the `multipass` contract validation path from the `productive-k3s-profiles` source checkout.

## Comando directo del repositorio

```bash
cd productive-k3s-profiles
SCENARIO=multipass PRODUCTIVE_K3S_INFRA_REPO_DIR=../productive-k3s-infra bash ./scripts/productive-k3s-profiles-dev.sh test-contract
```

## Vista del cast

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/profiles/validate-contract-multipass.cast" data-cast-title="Validate Contract Multipass">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/profiles/validate-contract-multipass.cast">Abrir cast crudo</a>
  </div>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-profiles)
- [Abrir cast crudo](../../../assets/playbooks/casts/profiles/validate-contract-multipass.cast)

## Detalle del escenario

Run the `multipass` contract validation path from the `productive-k3s-profiles` source checkout.

Use this when you only need to verify the declared scenario contract and not the deeper static helper checks.
