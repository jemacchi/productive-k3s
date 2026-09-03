<!-- generated: playbooks-export-mkdocs -->
# Live Multipass

Run the live `multipass` scenario validation path from the `productive-k3s-profiles` source checkout.

## Repository-local command

```bash
cd productive-k3s-profiles
SCENARIO=multipass PRODUCTIVE_K3S_INFRA_REPO_DIR=../productive-k3s-infra bash ./scripts/productive-k3s-profiles-dev.sh test-live
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/profiles/live-multipass.cast" data-cast-title="Live Multipass">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/profiles/live-multipass.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-profiles)
- [Open raw cast](../../../assets/playbooks/casts/profiles/live-multipass.cast)

## Scenario details

Run the live `multipass` scenario validation path from the `productive-k3s-profiles` source checkout.

Use this when you want to validate the local multi-node flow end to end. Record it only from a clean local environment or disposable VM so the log stays meaningful.
