<!-- generated: playbooks-export-mkdocs -->
# Live Stack Export Ubuntu24

Export a stack bundle through the CLI and replay it in a fresh Ubuntu 24 VM.

## Repository-local command

```bash
cd productive-k3s-cli
bash ./tests/live-cli-stack-export-ubuntu24.sh
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/cli/live-stack-export-ubuntu24.cast" data-cast-title="Live Stack Export Ubuntu24">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/cli/live-stack-export-ubuntu24.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-cli)
- [Open raw cast](../../../assets/playbooks/casts/cli/live-stack-export-ubuntu24.cast)

## Scenario details

Export a stack bundle through the CLI and replay it in a fresh Ubuntu 24 VM.

Use this when you want a real proof that:

- `pk3s stack export` produces a runnable installer archive
- the exported bundle can be replayed in a fresh VM
- the replayed stack actually creates the expected namespace

The wrapper defaults to the local sibling `core`, `infra`, `profiles`, and `addons` checkouts on `development`.

Run this only when `multipass` and network access for the stack inputs are available.
