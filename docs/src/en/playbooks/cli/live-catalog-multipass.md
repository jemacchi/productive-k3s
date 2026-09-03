<!-- generated: playbooks-export-mkdocs -->
# Live Catalog Multipass

Run the live catalog-backed `multipass` lifecycle through the CLI validator.

## Repository-local command

```bash
cd productive-k3s-cli
bash ./tests/live-cli-catalog-multipass.sh
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/cli/live-catalog-multipass.cast" data-cast-title="Live Catalog Multipass">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/cli/live-catalog-multipass.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-cli)
- [Open raw cast](../../../assets/playbooks/casts/cli/live-catalog-multipass.cast)

## Scenario details

Run the live catalog-backed `multipass` lifecycle through the CLI validator.

Use this when you want a real end-to-end proof of:

- catalog-backed profile validation
- package-first infra install and status
- catalog-backed addon validation and install
- cleanup through the published operator surface

The wrapper defaults to the local sibling `core`, `infra`, `profiles`, and `addons` checkouts on `development` and assigns a unique `PK3S_CLI_MULTIPASS_CLUSTER_PREFIX` unless you override it.

Run this only when `multipass` and the required local prerequisites are available.
