<!-- generated: playbooks-export-mkdocs -->
# Validate Profile Source Multipass

Validate the public local `multipass` source profile contract from the sibling `productive-k3s-profiles` checkout.

## Comando directo del repositorio

```bash
cd productive-k3s-infra
PRODUCTIVE_K3S_PROFILES_REPO_DIR=../productive-k3s-profiles \
  bash ./productive-k3s-infra.sh validate-profile --profile ../productive-k3s-profiles/profiles/local/multipass/1-server-2-agents.env
```

## Vista del cast

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/infra/validate-profile-source-multipass.cast" data-cast-title="Validate Profile Source Multipass">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/infra/validate-profile-source-multipass.cast">Abrir cast crudo</a>
  </div>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-infra)
- [Abrir cast crudo](../../../assets/playbooks/casts/infra/validate-profile-source-multipass.cast)

## Detalle del escenario

Validate the public local `multipass` source profile contract from the sibling `productive-k3s-profiles` checkout.

Use this when you want the simplest source-level validation for the local multi-node profile before planning or applying it.
