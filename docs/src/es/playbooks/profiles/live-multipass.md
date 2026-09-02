<!-- generated: playbooks-export-mkdocs -->
# Live Multipass

Run the live `multipass` scenario validation path from the `productive-k3s-profiles` source checkout.

## Comando directo del repositorio

```bash
cd productive-k3s-profiles
SCENARIO=multipass PRODUCTIVE_K3S_INFRA_REPO_DIR=../productive-k3s-infra bash ./scripts/productive-k3s-profiles-dev.sh test-live
```

## Vista del cast

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/profiles/live-multipass.cast" data-cast-title="Live Multipass">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/profiles/live-multipass.cast">Abrir cast crudo</a>
  </div>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-profiles)
- [Abrir cast crudo](../../../assets/playbooks/casts/profiles/live-multipass.cast)

## Detalle del escenario

Run the live `multipass` scenario validation path from the `productive-k3s-profiles` source checkout.

Use this when you want to validate the local multi-node flow end to end. Record it only from a clean local environment or disposable VM so the log stays meaningful.
