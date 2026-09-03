<!-- generated: playbooks-export-mkdocs -->
# Stack Base Longhorn And Rancher Checks

Run the typical Longhorn and Rancher post-install checks for the `base` stack.

## Comando directo del repositorio

```bash
bash ./utils/inspect-longhorn.sh
bash ./utils/inspect-longhorn-volumes.sh
bash ./utils/inspect-rancher.sh
bash -lc sudo\ k3s\ kubectl\ get\ pods\ -n\ longhorn-system\ -o\ wide
bash -lc sudo\ k3s\ kubectl\ get\ pods\ -n\ cattle-system\ -o\ wide
bash -lc sudo\ k3s\ kubectl\ rollout\ status\ deploy/rancher\ -n\ cattle-system\ --timeout=60s
```

## Vista del cast

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/core/stack-base-longhorn-and-rancher-checks.cast" data-cast-title="Stack Base Longhorn And Rancher Checks">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/core/stack-base-longhorn-and-rancher-checks.cast">Abrir cast crudo</a>
  </div>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-core)
- [Abrir cast crudo](../../../assets/playbooks/casts/core/stack-base-longhorn-and-rancher-checks.cast)

## Detalle del escenario

Run the typical Longhorn and Rancher post-install checks for the `base` stack.

This scenario is intentionally operational, not installation-focused.
