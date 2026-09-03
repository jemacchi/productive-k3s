<!-- generated: playbooks-export-mkdocs -->
# Addon Install Packaged Public Host

Install a packaged addon and request a basic public ingress host.

## Comando directo del repositorio

_No direct command captured._

## Vista del cast

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/core/addon-install-packaged-public-host.cast" data-cast-title="Addon Install Packaged Public Host">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/core/addon-install-packaged-public-host.cast">Abrir cast crudo</a>
  </div>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-core)
- [Abrir cast crudo](../../../assets/playbooks/casts/core/addon-install-packaged-public-host.cast)

## Detalle del escenario

Install a packaged addon and request a basic public ingress host.

```bash
PRODUCTIVE_K3S_CORE_PLAYBOOK_ADDON_TGZ=/tmp/nginx-addon.tgz \
PRODUCTIVE_K3S_CORE_PLAYBOOK_PUBLIC_HOST=nginx-01.k3s.lab.internal \
```
