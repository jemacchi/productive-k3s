<!-- generated: playbooks-export-mkdocs -->
# Bundle Info And Bom

Inspect the Infra CLI/runtime metadata and bill of materials from a local `productive-k3s-infra` checkout.

## Repository-local command

```bash
cd productive-k3s-infra
bash -lc './productive-k3s-infra.sh bundle info --json && printf "\n" && ./productive-k3s-infra.sh bom --json'
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/infra/bundle-info-and-bom.cast" data-cast-title="Bundle Info And Bom">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/infra/bundle-info-and-bom.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-infra)
- [Open raw cast](../../../assets/playbooks/casts/infra/bundle-info-and-bom.cast)

## Scenario details

Inspect the Infra CLI/runtime metadata and bill of materials from a local `productive-k3s-infra` checkout.

Use this when you want the fastest non-mutating inspection of:

- the current Infra bundle identity
- runtime metadata exposed by the CLI
- the bill of materials that the current checkout reports
