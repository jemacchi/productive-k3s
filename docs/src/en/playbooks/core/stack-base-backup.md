<!-- generated: playbooks-export-mkdocs -->
# Stack Base Backup

Capture a backup while enabling stack-aware addon hooks through `PRODUCTIVE_K3S_STACK_NAME=base`.

## Repository-local command

```bash
cd productive-k3s-core
PRODUCTIVE_K3S_STACK_NAME=base ./productive-k3s-core.sh backup '/tmp/pk3s-base-stack-backup'
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/core/stack-base-backup.cast" data-cast-title="Stack Base Backup">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/core/stack-base-backup.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-core)
- [Open raw cast](../../../assets/playbooks/casts/core/stack-base-backup.cast)

## Scenario details

Capture a backup while enabling stack-aware addon hooks through `PRODUCTIVE_K3S_STACK_NAME=base`.

```bash
PRODUCTIVE_K3S_CORE_PLAYBOOK_BACKUP_DIR=/tmp/pk3s-base-stack-backup \
```
