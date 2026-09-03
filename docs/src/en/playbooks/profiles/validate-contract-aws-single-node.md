<!-- generated: playbooks-export-mkdocs -->
# Validate Contract Aws Single Node

Run the `aws-single-node` contract validation path from the `productive-k3s-profiles` source checkout.

## Repository-local command

```bash
cd productive-k3s-profiles
SCENARIO=aws-single-node PRODUCTIVE_K3S_INFRA_REPO_DIR=../productive-k3s-infra bash ./scripts/productive-k3s-profiles-dev.sh test-contract
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/profiles/validate-contract-aws-single-node.cast" data-cast-title="Validate Contract Aws Single Node">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/profiles/validate-contract-aws-single-node.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-profiles)
- [Open raw cast](../../../assets/playbooks/casts/profiles/validate-contract-aws-single-node.cast)

## Scenario details

Run the `aws-single-node` contract validation path from the `productive-k3s-profiles` source checkout.

Use this when you want a fast contract-only check for the cloud profile surface.
