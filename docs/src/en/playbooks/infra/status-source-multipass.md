<!-- generated: playbooks-export-mkdocs -->
# Status Source Multipass

Re-render and print the source-based `multipass` generated cluster metadata.

## Repository-local command

```bash
cd productive-k3s-profiles/scenarios/local/multipass
make status
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/infra/status-source-multipass.cast" data-cast-title="Status Source Multipass">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/infra/status-source-multipass.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-infra)
- [Open raw cast](../../../assets/playbooks/casts/infra/status-source-multipass.cast)

## Scenario details

Re-render and print the source-based `multipass` generated cluster metadata.

Use this after a prior `infra-up`, `cluster-up`, or `up` path when you want to inspect `generated/cluster.json` and the refreshed runtime metadata.
