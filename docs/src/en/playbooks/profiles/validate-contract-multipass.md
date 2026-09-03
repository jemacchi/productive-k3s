<!-- generated: playbooks-export-mkdocs -->
# Validate Contract Multipass

Run the `multipass` contract validation path from the `productive-k3s-profiles` source checkout.

## Repository-local command

```bash
cd productive-k3s-profiles
SCENARIO=multipass PRODUCTIVE_K3S_INFRA_REPO_DIR=../productive-k3s-infra bash ./scripts/productive-k3s-profiles-dev.sh test-contract
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/profiles/validate-contract-multipass.cast" data-cast-title="Validate Contract Multipass">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/profiles/validate-contract-multipass.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-profiles)
- [Open raw cast](../../../assets/playbooks/casts/profiles/validate-contract-multipass.cast)

## Scenario details

Run the `multipass` contract validation path from the `productive-k3s-profiles` source checkout.

Use this when you only need to verify the declared scenario contract and not the deeper static helper checks.
