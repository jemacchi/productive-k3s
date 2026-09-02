<!-- generated: playbooks-export-mkdocs -->
# Apply Server

Run the preferred core-only installation on a supported host.

## Repository-local command

```bash
cd productive-k3s-core
bash ./productive-k3s-core.sh apply --mode server
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/core/apply-server.cast" data-cast-title="Apply Server">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/core/apply-server.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-core)
- [Open raw cast](../../../assets/playbooks/casts/core/apply-server.cast)

## Scenario details

## Goal

Run the preferred core-only installation on a supported host.

## When to use it

- you want the base `productive-k3s-core` contract without jumping into stack-heavy flows
- you are bootstrapping a fresh supported VM or host
- you want the cleanest starting point before later validation or stack work

## Prerequisites

- local checkout at `productive-k3s-core`
- supported Linux host or VM
- successful preflight strongly recommended
- operator is ready to allow package installation and service changes

## Expected result

- `k3s` and related base runtime components installed or reused
- local cluster becomes available for post-apply validation
- mutating host changes, package operations, and sudo prompts

## Notes

- this playbook is intentionally the first real mutating scenario in the set
- use a disposable VM or a host you explicitly intend to bootstrap
