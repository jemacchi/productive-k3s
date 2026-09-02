<!-- generated: playbooks-export-mkdocs -->
# Validate Contract Onprem Basic

Run the `onprem-basic` contract validation path from the `productive-k3s-profiles` source checkout.

## Repository-local command

```bash
cd productive-k3s-profiles
SCENARIO=onprem-basic PRODUCTIVE_K3S_INFRA_REPO_DIR=../productive-k3s-infra bash ./scripts/productive-k3s-profiles-dev.sh test-contract
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/profiles/validate-contract-onprem-basic.cast" data-cast-title="Validate Contract Onprem Basic">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/profiles/validate-contract-onprem-basic.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-profiles)
- [Open raw cast](../../../assets/playbooks/casts/profiles/validate-contract-onprem-basic.cast)

## Scenario details

Run the `onprem-basic` contract validation path from the `productive-k3s-profiles` source checkout.

Use this when you only need the short schema and layout proof for the public on-prem scenario.
