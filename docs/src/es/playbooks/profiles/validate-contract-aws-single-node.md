<!-- generated: playbooks-export-mkdocs -->
# Validate Contract Aws Single Node

Run the `aws-single-node` contract validation path from the `productive-k3s-profiles` source checkout.

## Comando directo del repositorio

```bash
cd productive-k3s-profiles
SCENARIO=aws-single-node PRODUCTIVE_K3S_INFRA_REPO_DIR=../productive-k3s-infra bash ./scripts/productive-k3s-profiles-dev.sh test-contract
```

## Vista del cast

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/profiles/validate-contract-aws-single-node.cast" data-cast-title="Validate Contract Aws Single Node">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/profiles/validate-contract-aws-single-node.cast">Abrir cast crudo</a>
  </div>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-profiles)
- [Abrir cast crudo](../../../assets/playbooks/casts/profiles/validate-contract-aws-single-node.cast)

## Detalle del escenario

Run the `aws-single-node` contract validation path from the `productive-k3s-profiles` source checkout.

Use this when you want a fast contract-only check for the cloud profile surface.
