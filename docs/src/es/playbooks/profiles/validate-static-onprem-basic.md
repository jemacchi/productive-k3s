<!-- generated: playbooks-export-mkdocs -->
# Validate Static Onprem Basic

Run the `onprem-basic` static validation path from the `productive-k3s-profiles` source checkout.

## Comando directo del repositorio

```bash
cd productive-k3s-profiles
SCENARIO=onprem-basic PRODUCTIVE_K3S_INFRA_REPO_DIR=../productive-k3s-infra bash ./scripts/productive-k3s-profiles-dev.sh test-static
```

## Vista del cast

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/profiles/validate-static-onprem-basic.cast" data-cast-title="Validate Static Onprem Basic">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/profiles/validate-static-onprem-basic.cast">Abrir cast crudo</a>
  </div>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-profiles)
- [Abrir cast crudo](../../../assets/playbooks/casts/profiles/validate-static-onprem-basic.cast)

## Detalle del escenario

Run the `onprem-basic` static validation path from the `productive-k3s-profiles` source checkout.

Use this when you want to validate the public remote-host scenario without requiring a reachable host yet.
