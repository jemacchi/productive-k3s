<!-- generated: playbooks-export-mkdocs -->
# Destroy Profile Packaged Onprem Basic Rejected

Show the explicit public guardrail that packaged `onprem-basic` does not support `destroy`.

## Repository-local command

```bash
cd productive-k3s-infra
./productive-k3s-infra.sh profile destroy --tgz /abs/path/to/on-prem-basic-profile.tgz
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/infra/destroy-profile-packaged-onprem-basic-rejected.cast" data-cast-title="Destroy Profile Packaged Onprem Basic Rejected">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/infra/destroy-profile-packaged-onprem-basic-rejected.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-infra)
- [Open raw cast](../../../assets/playbooks/casts/infra/destroy-profile-packaged-onprem-basic-rejected.cast)

## Scenario details

Show the explicit public guardrail that packaged `onprem-basic` does not support `destroy`.

```bash
PRODUCTIVE_K3S_INFRA_PLAYBOOK_PROFILE_TGZ=/abs/path/to/on-prem-basic-profile.tgz \
```

Expected behavior:

- the command fails intentionally
- Infra reports that packaged `destroy` is unsupported for the `onprem-basic` scenario

Use this when you want to make the package-boundary contract visible instead of assuming every scenario supports symmetric teardown through the packaged CLI.
