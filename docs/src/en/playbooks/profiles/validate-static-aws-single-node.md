<!-- generated: playbooks-export-mkdocs -->
# Validate Static Aws Single Node

Run the `aws-single-node` static validation path without applying cloud changes.

## Repository-local command

```bash
cd productive-k3s-profiles
SCENARIO=aws-single-node PRODUCTIVE_K3S_INFRA_REPO_DIR=../productive-k3s-infra bash ./scripts/productive-k3s-profiles-dev.sh test-static
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/profiles/validate-static-aws-single-node.cast" data-cast-title="Validate Static Aws Single Node">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/profiles/validate-static-aws-single-node.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-profiles)
- [Open raw cast](../../../assets/playbooks/casts/profiles/validate-static-aws-single-node.cast)

## Scenario details

Run the `aws-single-node` static validation path without applying cloud changes.

Use this when you want the strongest non-live AWS profile proof before involving cloud credentials or a real account.
