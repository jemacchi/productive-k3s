<!-- generated: playbooks-export-mkdocs -->
# Stack Export Base

Export a packaged stack artifact into a self-contained installer bundle.

## Repository-local command

```bash
cd productive-k3s-core
bash ./productive-k3s-core.sh stack export --tgz /tmp/base-stack.tgz --output /tmp/base-installer
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/core/stack-export-base.cast" data-cast-title="Stack Export Base">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/core/stack-export-base.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-core)
- [Open raw cast](../../../assets/playbooks/casts/core/stack-export-base.cast)

## Scenario details

Export a packaged stack artifact into a self-contained installer bundle.

```bash
PRODUCTIVE_K3S_CORE_PLAYBOOK_STACK_TGZ=/tmp/base-stack.tgz \
PRODUCTIVE_K3S_CORE_PLAYBOOK_EXPORT_OUTPUT=/tmp/base-installer \
```
