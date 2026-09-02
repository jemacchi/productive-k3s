<!-- generated: playbooks-export-mkdocs -->
# Exported Installer K3sup Ubuntu24

Validate the self-contained exported base installer on Ubuntu 24.04 with `PRODUCTIVE_K3S_ENGINE=k3sup`.

## Repository-local command

```bash
cd productive-k3s-core
make -C ./tests test-exported-stack-installer-k3sup-ubuntu24
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/core/exported-installer-k3sup-ubuntu24.cast" data-cast-title="Exported Installer K3sup Ubuntu24">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/core/exported-installer-k3sup-ubuntu24.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-core)
- [Open raw cast](../../../assets/playbooks/casts/core/exported-installer-k3sup-ubuntu24.cast)

## Scenario details

Validate the self-contained exported base installer on Ubuntu 24.04 with `PRODUCTIVE_K3S_ENGINE=k3sup`.

Use this when you want a real VM-backed proof that the optional `k3sup` engine survives the export-and-replay path for the base installer.

Current scope:

- this is a real VM-backed `core` execution path, not a synthetic review
- it proves engine propagation through `stack export` and exported `install.sh`
- it does not claim a separate `k3sup` stack matrix beyond this Ubuntu 24.04 exported-installer contract
