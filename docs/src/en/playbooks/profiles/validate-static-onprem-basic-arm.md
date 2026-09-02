<!-- generated: playbooks-export-mkdocs -->
# Validate Static Onprem Basic Arm

Run the `onprem-basic-arm` static validation path from the `productive-k3s-profiles` source checkout.

## Repository-local command

```bash
cd productive-k3s-profiles
SCENARIO=onprem-basic-arm PRODUCTIVE_K3S_INFRA_REPO_DIR=../productive-k3s-infra bash ./scripts/productive-k3s-profiles-dev.sh test-static
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/profiles/validate-static-onprem-basic-arm.cast" data-cast-title="Validate Static Onprem Basic Arm">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/profiles/validate-static-onprem-basic-arm.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-profiles)
- [Open raw cast](../../../assets/playbooks/casts/profiles/validate-static-onprem-basic-arm.cast)

## Scenario details

Run the `onprem-basic-arm` static validation path from the `productive-k3s-profiles` source checkout.

Use this when you need to confirm that the ARM remote-host scenario still validates after scenario-local script and fallback changes.
