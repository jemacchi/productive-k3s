<!-- generated: playbooks-export-mkdocs -->
# Down Source Multipass

Destroy the source-based `multipass` scenario VMs through the sibling `productive-k3s-profiles` checkout.

## Repository-local command

```bash
cd productive-k3s-profiles/scenarios/local/multipass
make down
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/infra/down-source-multipass.cast" data-cast-title="Down Source Multipass">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/infra/down-source-multipass.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-infra)
- [Open raw cast](../../../assets/playbooks/casts/infra/down-source-multipass.cast)

## Scenario details

Destroy the source-based `multipass` scenario VMs through the sibling `productive-k3s-profiles` checkout.

Use this when you want the source-oriented scenario teardown instead of the package-first `profile destroy` surface.
