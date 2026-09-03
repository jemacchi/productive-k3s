<!-- generated: playbooks-export-mkdocs -->
# Exported Installer Replay Multipass

Run the strongest current end-to-end proof for the Infra exported installer contract on the `multipass` profile.

## Comando directo del repositorio

```bash
cd productive-k3s-infra
PRODUCTIVE_K3S_PROFILES_REPO_DIR=../productive-k3s-profiles \
  bash ./tests/test-profile-export-artifact.sh
```

## Vista del cast

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/infra/exported-installer-replay-multipass.cast" data-cast-title="Exported Installer Replay Multipass">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/infra/exported-installer-replay-multipass.cast">Abrir cast crudo</a>
  </div>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-infra)
- [Abrir cast crudo](../../../assets/playbooks/casts/infra/exported-installer-replay-multipass.cast)

## Detalle del escenario

Run the strongest current end-to-end proof for the Infra exported installer contract on the `multipass` profile.

What this demonstrates:

- source profile export into an installer bundle
- bundled `install.sh` replay on a real local `multipass` topology
- packaged `profile status --tgz ...` replay after install
- validation of the expected stack namespaces
- cleanup of the created instances during test teardown

Use this when you want the most convincing Infra playbook for the self-contained installer story, even though it is longer than the basic Stage 1 examples.
