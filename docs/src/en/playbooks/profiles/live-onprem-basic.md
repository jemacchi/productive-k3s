<!-- generated: playbooks-export-mkdocs -->
# Live Onprem Basic

Run the live `onprem-basic` remote validation path from the `productive-k3s-profiles` source checkout.

## Repository-local command

```bash
cd productive-k3s-profiles
SCENARIO=onprem-basic PRODUCTIVE_K3S_INFRA_REPO_DIR=../productive-k3s-infra bash ./scripts/productive-k3s-profiles-dev.sh test-live
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/profiles/live-onprem-basic.cast" data-cast-title="Live Onprem Basic">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/profiles/live-onprem-basic.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-profiles)
- [Open raw cast](../../../assets/playbooks/casts/profiles/live-onprem-basic.cast)

## Scenario details

Run the live `onprem-basic` remote validation path from the `productive-k3s-profiles` source checkout.

Use this when a real reachable remote host is available and you want a substantive public-source proof for the default on-prem profile.
