<!-- generated: playbooks-export-mkdocs -->
# Profile List And Show Catalog

Review the catalog-backed profile discovery surface and one concrete published profile summary.

## Repository-local command

```bash
cd productive-k3s-cli
bash -lc './pk3s profile list && printf "\n" && ./pk3s profile show aws-single-node-basic'
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/cli/profile-list-and-show-catalog.cast" data-cast-title="Profile List And Show Catalog">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/cli/profile-list-and-show-catalog.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-cli)
- [Open raw cast](../../../assets/playbooks/casts/cli/profile-list-and-show-catalog.cast)

## Scenario details

Review the catalog-backed profile discovery surface and one concrete published profile summary.

Use this when you want to show:

- the published profile catalog visible through `pk3s`
- which profiles require local overrides
- the install inputs summary exposed by a specific packaged profile
