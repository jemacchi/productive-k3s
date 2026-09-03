<!-- generated: playbooks-export-mkdocs -->
# Live Profile Export Multipass

Export a profile bundle through the CLI and replay it into a live `multipass` cluster.

## Repository-local command

```bash
cd productive-k3s-cli
bash ./tests/live-cli-profile-export-multipass.sh
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/cli/live-profile-export-multipass.cast" data-cast-title="Live Profile Export Multipass">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/cli/live-profile-export-multipass.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-cli)
- [Open raw cast](../../../assets/playbooks/casts/cli/live-profile-export-multipass.cast)

## Scenario details

Export a profile bundle through the CLI and replay it into a live `multipass` cluster.

Use this when you want a real proof that:

- `pk3s profile export` produces a replayable installer archive
- the exported profile can bootstrap a fresh `multipass` cluster
- the replayed cluster reaches the expected namespace set before cleanup

The wrapper defaults to the local sibling `core`, `infra`, `profiles`, and `addons` checkouts on `development` and assigns a unique `PK3S_CLI_MULTIPASS_CLUSTER_PREFIX` unless you override it.

Run this only when `multipass` and the sibling product checkouts are available.
