<!-- generated: playbooks-export-mkdocs -->
# Addon Install Packaged Public Host

Install a packaged addon and request a basic public ingress host.

## Repository-local command

_No direct command captured._

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/core/addon-install-packaged-public-host.cast" data-cast-title="Addon Install Packaged Public Host">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/core/addon-install-packaged-public-host.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-core)
- [Open raw cast](../../../assets/playbooks/casts/core/addon-install-packaged-public-host.cast)

## Scenario details

Install a packaged addon and request a basic public ingress host.

```bash
PRODUCTIVE_K3S_CORE_PLAYBOOK_ADDON_TGZ=/tmp/nginx-addon.tgz \
PRODUCTIVE_K3S_CORE_PLAYBOOK_PUBLIC_HOST=nginx-01.k3s.lab.internal \
```
