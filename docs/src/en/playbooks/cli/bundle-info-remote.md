<!-- generated: playbooks-export-mkdocs -->
# Bundle Info Remote

Inspect published remote bundle resolution for both `core` and `infra` through `pk3s`.

## Repository-local command

```bash
cd productive-k3s-cli
bash -lc 'PRODUCTIVE_K3S_SOURCE=remote ./pk3s bundle core info --json && printf "\n" && PRODUCTIVE_K3S_SOURCE=remote ./pk3s bundle infra info --json'
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/cli/bundle-info-remote.cast" data-cast-title="Bundle Info Remote">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/cli/bundle-info-remote.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-cli)
- [Open raw cast](../../../assets/playbooks/casts/cli/bundle-info-remote.cast)

## Scenario details

Inspect published remote bundle resolution for both `core` and `infra` through `pk3s`.

Use this when you want a short proof that:

- the remote release resolution path is healthy
- `pk3s` can fetch published bundle metadata without doing an install
- the public bundle versions line up with what the CLI expects
