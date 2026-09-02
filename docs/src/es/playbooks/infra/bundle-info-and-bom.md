<!-- generated: playbooks-export-mkdocs -->
# Bundle Info And Bom

Inspect the Infra CLI/runtime metadata and bill of materials from a local `productive-k3s-infra` checkout.

## Comando directo del repositorio

```bash
cd productive-k3s-infra
bash -lc './productive-k3s-infra.sh bundle info --json && printf "\n" && ./productive-k3s-infra.sh bom --json'
```

## Vista del cast

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/infra/bundle-info-and-bom.cast" data-cast-title="Bundle Info And Bom">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/infra/bundle-info-and-bom.cast">Abrir cast crudo</a>
  </div>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-infra)
- [Abrir cast crudo](../../../assets/playbooks/casts/infra/bundle-info-and-bom.cast)

## Detalle del escenario

Inspect the Infra CLI/runtime metadata and bill of materials from a local `productive-k3s-infra` checkout.

Use this when you want the fastest non-mutating inspection of:

- the current Infra bundle identity
- runtime metadata exposed by the CLI
- the bill of materials that the current checkout reports
