<!-- generated: playbooks-export-mkdocs -->
# Addon Public Host Nginx

Exercise the `nginx` live install path that uses the narrow public-host exposure contract consumed by `core`.

## Comando directo del repositorio

```bash
cd productive-k3s-addons
ADDON=nginx PRODUCTIVE_K3S_CORE_REPO_DIR=../productive-k3s-core PK3S_ADDON_PUBLIC_HOST=nginx-01.k3s.lab.internal make -C ./tests test-live
```

## Vista del cast

<div class="pk3s-playbook-cast-empty">
  <p>Todavía no hay un cast canónico publicado para este playbook.</p>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-addons)

## Detalle del escenario

## Goal

Exercise the `nginx` live install path that uses the narrow public-host exposure contract consumed by `core`.

## When to use it

- when validating the only generic public exposure path we support today
- when checking that `nginx` remains the reference add-on for public ingress examples
- when you want a focused live case instead of the full matrix

## Prerequisites

- local checkout at `productive-k3s-addons`
- local checkout at `productive-k3s-core`
- local cluster already reachable through `KUBECONFIG` or `PK3S_KUBE_CONTEXT`
- `PK3S_ADDON_PUBLIC_HOST` exported with the desired FQDN

## Expected result

- the add-on is packaged to `.tgz` internally by the repo test harness
- `core` installs it through the artifact-first public contract
- live cluster mutations occur
