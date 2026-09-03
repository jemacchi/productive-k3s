<!-- generated: playbooks-export-mkdocs -->
# Doctor Without Profiles Warning

Run the explicit warning path for `productive-k3s-infra doctor` without wiring the sibling `productive-k3s-profiles` checkout.

## Comando directo del repositorio

```bash
cd productive-k3s-infra
env -u PRODUCTIVE_K3S_PROFILES_REPO_DIR bash ./productive-k3s-infra.sh doctor
```

## Vista del cast

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/infra/doctor-without-profiles-warning.cast" data-cast-title="Doctor Without Profiles Warning">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/infra/doctor-without-profiles-warning.cast">Abrir cast crudo</a>
  </div>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-infra)
- [Abrir cast crudo](../../../assets/playbooks/casts/infra/doctor-without-profiles-warning.cast)

## Detalle del escenario

Run the explicit warning path for `productive-k3s-infra doctor` without wiring the sibling `productive-k3s-profiles` checkout.

Use this when you want to review the operator guidance shown for source-based flows on a shell where the local profiles checkout is not configured.
