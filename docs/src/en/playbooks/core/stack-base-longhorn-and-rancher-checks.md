<!-- generated: playbooks-export-mkdocs -->
# Stack Base Longhorn And Rancher Checks

Run the typical Longhorn and Rancher post-install checks for the `base` stack.

## Repository-local command

```bash
bash ./utils/inspect-longhorn.sh
bash ./utils/inspect-longhorn-volumes.sh
bash ./utils/inspect-rancher.sh
bash -lc sudo\ k3s\ kubectl\ get\ pods\ -n\ longhorn-system\ -o\ wide
bash -lc sudo\ k3s\ kubectl\ get\ pods\ -n\ cattle-system\ -o\ wide
bash -lc sudo\ k3s\ kubectl\ rollout\ status\ deploy/rancher\ -n\ cattle-system\ --timeout=60s
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/core/stack-base-longhorn-and-rancher-checks.cast" data-cast-title="Stack Base Longhorn And Rancher Checks">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/core/stack-base-longhorn-and-rancher-checks.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-core)
- [Open raw cast](../../../assets/playbooks/casts/core/stack-base-longhorn-and-rancher-checks.cast)

## Scenario details

Run the typical Longhorn and Rancher post-install checks for the `base` stack.

This scenario is intentionally operational, not installation-focused.
