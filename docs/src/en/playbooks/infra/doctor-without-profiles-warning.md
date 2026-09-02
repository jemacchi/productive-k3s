<!-- generated: playbooks-export-mkdocs -->
# Doctor Without Profiles Warning

Run the explicit warning path for `productive-k3s-infra doctor` without wiring the sibling `productive-k3s-profiles` checkout.

## Repository-local command

```bash
cd productive-k3s-infra
env -u PRODUCTIVE_K3S_PROFILES_REPO_DIR bash ./productive-k3s-infra.sh doctor
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/infra/doctor-without-profiles-warning.cast" data-cast-title="Doctor Without Profiles Warning">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/infra/doctor-without-profiles-warning.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-infra)
- [Open raw cast](../../../assets/playbooks/casts/infra/doctor-without-profiles-warning.cast)

## Scenario details

Run the explicit warning path for `productive-k3s-infra doctor` without wiring the sibling `productive-k3s-profiles` checkout.

Use this when you want to review the operator guidance shown for source-based flows on a shell where the local profiles checkout is not configured.
