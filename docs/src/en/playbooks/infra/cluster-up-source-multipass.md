<!-- generated: playbooks-export-mkdocs -->
# Cluster Up Source Multipass

Run the source-based `multipass` cluster bootstrap phase from the sibling `productive-k3s-profiles` checkout.

## Repository-local command

```bash
cd productive-k3s-profiles/scenarios/local/multipass
make cluster-up
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/infra/cluster-up-source-multipass.cast" data-cast-title="Cluster Up Source Multipass">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/infra/cluster-up-source-multipass.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-infra)
- [Open raw cast](../../../assets/playbooks/casts/infra/cluster-up-source-multipass.cast)

## Scenario details

Run the source-based `multipass` cluster bootstrap phase from the sibling `productive-k3s-profiles` checkout.

Use this when the VMs already exist and you want to exercise the scenario-side `productive-k3s-core` bootstrap flow without recreating infrastructure first.
