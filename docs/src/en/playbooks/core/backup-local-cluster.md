<!-- generated: playbooks-export-mkdocs -->
# Backup Local Cluster

Capture a support-oriented backup snapshot of host and cluster state after bootstrap.

## Repository-local command

```bash
cd productive-k3s-core
bash ./productive-k3s-core.sh backup /tmp/pk3s-core-backup-01
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/core/backup-local-cluster.cast" data-cast-title="Backup Local Cluster">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/core/backup-local-cluster.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-core)
- [Open raw cast](../../../assets/playbooks/casts/core/backup-local-cluster.cast)

## Scenario details

## Goal

Capture a support-oriented backup snapshot of host and cluster state after bootstrap.

## When to use it

- before risky changes
- before cleanup or rollback work
- when capturing evidence for debugging

## Prerequisites

- local checkout at `productive-k3s-core`
- local cluster already bootstrapped
- sudo access
- enough free disk space under the target backup location

## Expected result

- backup directory with cluster, namespace, host, and runtime evidence
- `.tar.gz` archive next to the output directory

## Notes

- this is read-mostly from the cluster perspective, but it does require sudo and writes artifacts locally
- addon-specific backup hooks are out of scope for this first `core` batch
