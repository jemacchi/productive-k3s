<!-- generated: playbooks-export-mkdocs -->
# Live Multipass Remote

Run the live remote `multipass` lifecycle through the CLI validator.

## Repository-local command

```bash
cd productive-k3s-cli
bash ./tests/live-cli-multipass-remote.sh
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/cli/live-multipass-remote.cast" data-cast-title="Live Multipass Remote">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/cli/live-multipass-remote.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-cli)
- [Open raw cast](../../../assets/playbooks/casts/cli/live-multipass-remote.cast)

## Scenario details

Run the live remote `multipass` lifecycle through the CLI validator.

Use this when you want a real end-to-end proof of:

- `pk3s profile validate`
- `pk3s infra plan`
- `pk3s infra apply`
- `pk3s infra status`
- `pk3s infra destroy`

The wrapper defaults to the local sibling `core`, `infra`, `profiles`, and `addons` checkouts on `development` and assigns a unique `PK3S_CLI_MULTIPASS_CLUSTER_PREFIX` unless you override it.

Run this only when `multipass` and the required local prerequisites are available.
