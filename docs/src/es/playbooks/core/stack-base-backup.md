<!-- generated: playbooks-export-mkdocs -->
# Stack Base Backup

Capture a backup while enabling stack-aware addon hooks through `PRODUCTIVE_K3S_STACK_NAME=base`.

## Comando directo del repositorio

```bash
cd productive-k3s-core
PRODUCTIVE_K3S_STACK_NAME=base ./productive-k3s-core.sh backup '/tmp/pk3s-base-stack-backup'
```

## Vista del cast

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/core/stack-base-backup.cast" data-cast-title="Stack Base Backup">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/core/stack-base-backup.cast">Abrir cast crudo</a>
  </div>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-core)
- [Abrir cast crudo](../../../assets/playbooks/casts/core/stack-base-backup.cast)

## Detalle del escenario

Capture a backup while enabling stack-aware addon hooks through `PRODUCTIVE_K3S_STACK_NAME=base`.

```bash
PRODUCTIVE_K3S_CORE_PLAYBOOK_BACKUP_DIR=/tmp/pk3s-base-stack-backup \
```
