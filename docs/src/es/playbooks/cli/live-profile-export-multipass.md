<!-- generated: playbooks-export-mkdocs -->
# Live Profile Export Multipass

Export a profile bundle through the CLI and replay it into a live `multipass` cluster.

## Comando directo del repositorio

```bash
cd productive-k3s-cli
bash ./tests/live-cli-profile-export-multipass.sh
```

## Vista del cast

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/cli/live-profile-export-multipass.cast" data-cast-title="Live Profile Export Multipass">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/cli/live-profile-export-multipass.cast">Abrir cast crudo</a>
  </div>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-cli)
- [Abrir cast crudo](../../../assets/playbooks/casts/cli/live-profile-export-multipass.cast)

## Detalle del escenario

Export a profile bundle through the CLI and replay it into a live `multipass` cluster.

Use this when you want a real proof that:

- `pk3s profile export` produces a replayable installer archive
- the exported profile can bootstrap a fresh `multipass` cluster
- the replayed cluster reaches the expected namespace set before cleanup

The wrapper defaults to the local sibling `core`, `infra`, `profiles`, and `addons` checkouts on `development` and assigns a unique `PK3S_CLI_MULTIPASS_CLUSTER_PREFIX` unless you override it.

Run this only when `multipass` and the sibling product checkouts are available.
