# productive-k3s

Bootstrap and validation for a local `k3s` stack with:

- `cert-manager`
- `Longhorn`
- `Rancher`
- internal registry
- host NFS export

## Reasons Behind

`productive-k3s` is meant to provide a lightweight but production-oriented Kubernetes environment on a single host.

The intent is to avoid ad hoc local setups and replace them with a stack that is:

- reproducible
- closer to real Kubernetes operations
- simple enough to bootstrap, inspect, validate, back up, and tear down locally

Core rationale:

- `k3s`: lightweight Kubernetes distribution with low operational overhead and good compatibility with normal Kubernetes workflows
- `cert-manager`: in-cluster TLS lifecycle management so ingress-exposed services do not depend on manual certificate handling
- `Longhorn`: Kubernetes-native persistent storage for stateful workloads
- `Rancher`: management UI for cluster inspection and operations
- internal registry: local image push/pull workflow without depending on an external registry for every iteration
- host NFS export: simple host-to-cluster shared file path for datasets and other host-managed files

Detailed rationale:

- [Why this stack exists](./docs/reasons-behind.md)
- [Post-development testing guide](./docs/post-development-testing.md)
- [GitHub Actions and release automation](./docs/github-actions.md)

## Validated Platform Baseline

The scripts in this repository have been developed and tested primarily against Ubuntu-based hosts.

Validated baseline used during development:

- real host: Ubuntu `22.04`
- VM-based integration tests: Ubuntu images launched through `multipass`

What this means in practice:

- Ubuntu is the reference operating system for bootstrap, validation, rollback, cleanup, and VM-based testing
- host package installation logic currently assumes `apt-get`
- service management assumes `systemd`
- the current test harness and contributor validation flow are built around Ubuntu VMs

Support for other Linux distributions should not be assumed just because the scripts are shell-based.

If you want to validate another distro, treat that as explicit additional work:

- confirm package manager differences
- confirm service/unit name differences
- confirm filesystem and network cleanup behavior
- add dedicated test coverage for that platform

In practice, that may require:

- distro-specific branches in existing scripts
- additional test profiles
- or separate distro-specific helper scripts if the differences become large enough

Until that coverage exists, Ubuntu should be treated as the supported and validated base platform for this repository.

Current candidate platform work:

- Debian 12 `bookworm` is being prepared as a candidate validation target
- candidate validation is documented in [Debian 12 candidate platform](./docs/debian-12-candidate.md)
- Debian 12 should not be treated as fully supported until the required VM profile artifacts report `status: "success"`

## Minimum Hardware

This repository is designed first for a single-node host.

Practical minimum for the full stack:

- CPU: `4 vCPU`
- RAM: `12 GB`
- Disk: `60 GB` free SSD space

Recommended for a smoother experience:

- CPU: `6-8 vCPU`
- RAM: `16 GB`
- Disk: `100 GB+` free SSD space

Why these numbers are not lower:

- `Rancher` and `Longhorn` both add steady control-plane and management overhead
- the internal registry consumes persistent storage
- stateful workloads need headroom beyond the base platform itself
- low free disk space is especially problematic for `Longhorn`

Single-node note:

- this setup is intentionally biased toward single-node operation
- the bootstrap applies safer defaults for that mode, including `longhorn-single`, replica count `1`, and a reduced Longhorn minimal-available-space threshold

## Software Requirements

Software requirements depend on what you want to do with the repository.

### Base Requirements

Required for normal repository usage on the target host:

- Linux host with `systemd`
- `bash`
- `sudo`
- `curl`
- `getent`
- `make` if you want to use the provided `Makefile` targets

Expected platform assumptions:

- Ubuntu or another Debian-like Linux environment is the primary target
- `apt-get` is used by the bootstrap to install missing OS packages when needed
- the scripts are intended to run on a real host or VM, not on macOS or Windows directly

### Bootstrap And Validation

Required to bootstrap and validate the stack locally:

- `sudo`
- `curl`
- `systemctl`
- `getent`

Installed or reused by the managed workflow:

- `k3s`
- `helm`

Optional but commonly useful:

- standalone `kubectl`
- `docker` for registry push/pull validation with `--docker-registry-test`

### Rollback And Backup

Additional tools used by specific scripts:

- `jq` for `scripts/rollback-k3s-stack.sh`
- `tar` and `date` for `scripts/backup-k3s-stack.sh`

### Docker Smoke Test

Required only for the containerized smoke test:

- `docker`

Command:

```bash
make test-smoke
```

### VM-Based Test Harness

Required only for the VM-based test harness:

- `multipass`

Commands:

```bash
make test-core
./tests/test-in-vm.sh --platform ubuntu --image 24.04 --profile full
./tests/test-in-vm.sh --platform ubuntu --image 24.04 --profile full-rollback
./tests/test-in-vm.sh --platform ubuntu --image 24.04 --profile full-clean
```

CI note:

- GitHub Actions uses a hosted `ubuntu-24.04` runner without Multipass
- hosted bootstrap validation is triggered when a PR against `main` is opened, reopened, or marked ready for review
- local Multipass validation remains the authoritative path for real VM install, rollback, clean, and Debian candidate testing

### Utilities

Useful tools for inspection and troubleshooting:

- `jq`
- `curl`
- `docker` if you want to test registry push/pull from the host

### Practical Summary

If you only want to install and operate the stack locally, the practical host-side prerequisites are:

- `bash`
- `sudo`
- `curl`
- `getent`
- `make`

If you also want full contributor validation coverage, add:

- `docker`
- `multipass`
- `jq`

### Tool Reference

| Tool | Required | Used for |
| --- | --- | --- |
| `bash` | yes | running all repository scripts |
| `sudo` | yes | host changes, package installs, `k3s` operations |
| `curl` | yes | downloading `k3s`, `helm`, and endpoint checks |
| `getent` | yes | local hostname resolution checks during validation |
| `systemd` / `systemctl` | yes | managing `k3s`, `iscsid`, and NFS-related services |
| `make` | optional | convenience targets such as `make bootstrap`, `make validate`, `make test-smoke`, `make test-core` |
| `k3s` | managed by repo | installed or reused by bootstrap for cluster operations |
| `helm` | managed by repo | installed or reused by bootstrap for chart-based components |
| `kubectl` | optional | ad hoc user workflow; managed repo flow uses `sudo k3s kubectl` |
| `jq` | optional but recommended | required by rollback logic and useful for inspection and troubleshooting |
| `tar` | optional | used by backup/export workflows |
| `date` | optional | used by backup/export and artifact naming workflows |
| `docker` | optional | `make test-smoke` and `scripts/validate-k3s-stack.sh --docker-registry-test` |
| `multipass` | optional | VM-based validation with `make test-core` and `tests/test-in-vm.sh` |
| `apt-get` | expected on target host | installing missing OS packages during bootstrap |

Recommended CLI usage:

- the scripts are designed to work with `sudo k3s kubectl`
- a standalone `kubectl` binary in your `PATH` is not required for the managed workflow in this repository
- Docker is not required for the stack itself; `k3s` uses `containerd` and that is enough for bootstrap, validation, and normal operation
- Docker is only needed for optional host-side workflows such as `tests/test-in-docker.sh` and `scripts/validate-k3s-stack.sh --docker-registry-test`
- if you want a normal-user workflow for ad hoc commands, keep a valid `kubeconfig` in `~/.kube/config`
- if standalone `kubectl` is detected, the bootstrap can also sync `~/.kube/config` from the k3s kubeconfig so `kubectl` does not fail with `x509: certificate signed by unknown authority`
- the bootstrap logs this explicitly so users can tell whether `kubectl` was detected and whether that matters

## Scripts

### `scripts/bootstrap-k3s-stack.sh`

Installs or reuses existing components and optionally applies local host changes:

- `k3s`
- `helm`
- `cert-manager`
- `Longhorn`
- `Rancher`
- internal registry
- NFS server/export
- `/etc/hosts` entries
- local Docker trust for the registry certificate

Bootstrap flow:

1. Detect the current environment
2. Show a diagnosis of what is present or missing
3. Ask high-level `required` and `optional` decisions
4. Show a plan before applying changes
5. Apply or simulate the selected changes

Run manifest:

- every bootstrap run writes a structured JSON manifest under `runs/`
- file name format:
  - `bootstrap-YYYYMMDD-HHMMSS-<host>-<pid>.json`
- the manifest records:
  - detected state before execution
  - planned actions
  - non-sensitive settings
  - per-component execution result
- secrets and passwords are not stored in the manifest

Prompt labels:

- `[required]`: answering `n` stops the bootstrap because the remaining flow would not make sense
- `[optional]`: answering `n` skips that component or host integration and continues
- `[required for TLS-dependent installs]`: applies to `cert-manager` when Rancher or the registry need managed TLS

`cert-manager` behavior:

- `cert-manager` is only requested and planned when it is actually needed for TLS-dependent installs
- if you skip Rancher and the internal registry, the bootstrap does not force a `cert-manager` install

Longhorn safety note:

- the bootstrap can create the Longhorn data directory if needed
- it does **not** format or mount disks
- if you want dedicated storage for Longhorn, prepare and mount it before running the bootstrap
- this repository assumes a single-node-first setup, so the bootstrap now applies safer Longhorn defaults for that case:
  - replica count `1`
  - `longhorn-single` storage class for single-node workloads
  - lower minimal available storage threshold suitable for dev/lab environments

Usage:

```bash
./scripts/bootstrap-k3s-stack.sh
```

Dry-run:

```bash
./scripts/bootstrap-k3s-stack.sh --dry-run
```

### `scripts/validate-k3s-stack.sh`

Validates the stack and local host state.

Checks:

- `k3s` service
- `Ready` nodes
- healthy pods
- ingress
- default `StorageClass`
- `cert-manager`
- `Longhorn`
- `Rancher`
- internal registry
- registry PVC
- local DNS
- HTTPS access to Rancher and Registry
- NFS export
- optional real Docker validation

Validation behavior for optional components:

- if optional components such as Longhorn, Rancher, Registry, or cert-manager are not installed, the validator skips their component-specific checks instead of treating their absence as a failure
- the validator focuses on active pods and workload readiness; historical terminal pods such as `Completed`, `Evicted`, or old `Error` objects are reported as ignored context instead of immediate failures

Usage:

```bash
./scripts/validate-k3s-stack.sh
```

Strict mode:

```bash
./scripts/validate-k3s-stack.sh --strict
```

JSON output:

```bash
./scripts/validate-k3s-stack.sh --json
```

Real registry validation with Docker:

Anonymous mode:

```bash
./scripts/validate-k3s-stack.sh --docker-registry-test
```

Authenticated mode:

```bash
REGISTRY_USER=registry REGISTRY_PASSWORD='your-password' ./scripts/validate-k3s-stack.sh --docker-registry-test
```

### `scripts/backup-k3s-stack.sh`

Exports useful stack resources and configuration into a timestamped directory.

Includes:

- `sudo k3s kubectl get all -A`
- `ingress`, `cm`, `secret`, `pvc`, `pv`, `sc`, `certificates`, `issuers`, `clusterissuers`
- manifests for relevant namespaces
- `k3s.yaml`
- `k3s` server manifests
- `/etc/exports`
- `exportfs -v` output
- `hosts`
- Docker certs for the local registry

Usage:

```bash
./scripts/backup-k3s-stack.sh
```

Custom output directory:

```bash
./scripts/backup-k3s-stack.sh /tmp/my-k3s-backup
```

### `scripts/rollback-k3s-stack.sh`

Builds a rollback plan from a bootstrap run manifest and can apply the safe subset of that rollback. It now includes extra teardown handling for Rancher/Fleet/Turtles and Longhorn cluster-scoped artifacts so namespaces are less likely to get stuck during removal.

Usage:

```bash
./scripts/rollback-k3s-stack.sh --to runs/bootstrap-...json --plan
./scripts/rollback-k3s-stack.sh --to runs/bootstrap-...json --apply
```

Notes:

- intended for manifest-guided rollback of what a specific bootstrap run introduced
- does not treat reused components as rollback targets
- leaves high-impact host actions such as removing `k3s` or `helm` as manual review in this first implementation

### `scripts/clean-k3s-stack.sh`

Fully destructive local cleanup helper for tearing down the stack. It includes extra cleanup for Rancher/Fleet/Turtles and Longhorn cluster-scoped resources to reduce teardown hangs.

Usage:

```bash
./scripts/clean-k3s-stack.sh --plan
./scripts/clean-k3s-stack.sh --apply
```

Notes:

- this is not manifest-guided rollback
- this is a broad cleanup tool intended to remove the local stack completely
- it prints a strong warning and requires explicit confirmation before applying
- it removes cluster resources and local integrations, but does not delete arbitrary user files inside Longhorn or NFS data directories

### `tests/test-in-docker.sh`

Containerized smoke harness for testing the bootstrap in an isolated Ubuntu container. This is optional and requires Docker on the host.

Usage:

```bash
./tests/test-in-docker.sh
```

Notes:

- this is a smoke-only harness
- it builds the test image and runs `scripts/bootstrap-k3s-stack.sh --dry-run` inside the container
- the Docker image build only prepares the environment
- the actual bootstrap smoke test happens at `docker run` time, not during `docker build`
- it validates the bootstrap flow, prompts, dry-run behavior, and run manifest generation
- it does not perform a real `k3s` installation inside the container

### `tests/test-in-vm.sh`

Automated VM-based integration harness for real bootstrap testing. This requires Multipass on the host.

Usage:

```bash
./tests/test-in-vm.sh --platform ubuntu --image 24.04 --profile smoke
./tests/test-in-vm.sh --platform ubuntu --image 24.04 --profile core
./tests/test-in-vm.sh --platform ubuntu --image 24.04 --profile full
./tests/test-in-vm.sh --platform ubuntu --image 24.04 --profile full-clean
./tests/test-in-vm.sh --platform ubuntu --image 24.04 --profile full-rollback
./tests/test-in-vm.sh --platform debian12 --image https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2 --profile core
```

Profiles:

- `smoke`
  - launches a clean VM
  - copies the repository
  - runs `scripts/bootstrap-k3s-stack.sh --dry-run`
- `core`
  - launches a clean VM
  - installs `k3s` and `helm`
  - skips optional components
  - waits for the VM state to settle
  - runs `scripts/validate-k3s-stack.sh --strict`
- `full`
  - launches a clean VM
  - installs the full stack with default answers
  - waits for the stack to settle
  - runs `scripts/validate-k3s-stack.sh --strict`
- `full-clean`
  - runs the `full` profile
  - runs `scripts/clean-k3s-stack.sh --apply` inside the VM
  - verifies that `k3s` is no longer active
- `full-rollback`
  - runs the `full` profile
  - builds a rollback plan from the generated bootstrap manifest
  - applies the safe rollback actions
  - verifies that bootstrap-installed namespaces, the `selfsigned` ClusterIssuer, the NFS export, and managed `/etc/hosts` entries were removed

Notes:

- this is the recommended path for real installation tests of the bootstrap
- Multipass must be installed on the host before running it
- the VM is deleted automatically unless `--keep-vm` is passed
- `full` is heavier and slower; use it intentionally
- each VM test writes a host-side artifact JSON under `test-artifacts/`
- the latest bootstrap manifest from inside the VM is also copied into `test-artifacts/` when available
- `full-clean` and `full-rollback` are intended to validate teardown behavior, not just installation success

### `tests/test-in-vm-cleanup.sh`

Cleanup helper for Multipass-based test VMs.

Usage:

```bash
./tests/test-in-vm-cleanup.sh --name <vm-name>
./tests/test-in-vm-cleanup.sh --all --purge
```

Notes:

- requires Multipass on the host
- `--all` only targets VMs whose name starts with `productive-k3s-test-`

## Utilities

Helper scripts live under `utils/` and are intended as operational references for quick inspection and smoke checks.

- `utils/list-registry-images.sh`
  - lists repositories and tags from the in-cluster registry
  - supports optional basic auth via `REGISTRY_USER` and `REGISTRY_PASSWORD`
- `utils/inspect-ingress.sh`
  - shows Traefik service exposure plus all ingress rules
- `utils/inspect-rancher.sh`
  - shows Rancher namespace health, rollout, ingress, TLS-related objects, and a simple HTTPS probe
- `utils/inspect-longhorn.sh`
  - shows Longhorn namespace health, storage classes, settings, and volumes
- `utils/inspect-longhorn-volumes.sh`
  - focuses on PVC-to-Longhorn volume health, scheduling-related settings, and problematic volumes

Examples:

```bash
./utils/list-registry-images.sh
./utils/inspect-ingress.sh
./utils/inspect-rancher.sh
./utils/inspect-longhorn.sh
```

## Documentation

Operational how-tos live under `docs/`.

- [docs/README.md](/home/jmacchi/prg/jemacchi/productive-k3s/docs/README.md)
- [docs/k3s-checks.md](/home/jmacchi/prg/jemacchi/productive-k3s/docs/k3s-checks.md)
- [docs/ingress-checks.md](/home/jmacchi/prg/jemacchi/productive-k3s/docs/ingress-checks.md)
- [docs/rancher-checks.md](/home/jmacchi/prg/jemacchi/productive-k3s/docs/rancher-checks.md)
- [docs/registry-checks.md](/home/jmacchi/prg/jemacchi/productive-k3s/docs/registry-checks.md)
- [docs/longhorn-checks.md](/home/jmacchi/prg/jemacchi/productive-k3s/docs/longhorn-checks.md)
- [docs/longhorn-single-node-notes.md](/home/jmacchi/prg/jemacchi/productive-k3s/docs/longhorn-single-node-notes.md)
- [docs/certificate-checks.md](/home/jmacchi/prg/jemacchi/productive-k3s/docs/certificate-checks.md)

These documents focus on post-install verification and day-2 operational checks for the stack installed by this repository.

## Recommended Flow

1. Install or reconcile:

```bash
./scripts/bootstrap-k3s-stack.sh
```

2. Validate:

```bash
./scripts/validate-k3s-stack.sh
```

3. Optionally validate the registry with Docker:

```bash
./scripts/validate-k3s-stack.sh --docker-registry-test
```

4. Export a configuration backup:

```bash
./scripts/backup-k3s-stack.sh
```

5. If needed, review a rollback plan for a specific bootstrap run:

```bash
./scripts/rollback-k3s-stack.sh --to runs/bootstrap-...json --plan
```

6. If you want an isolated smoke test of the bootstrap flow:

```bash
./tests/test-in-docker.sh
```

7. If you want real bootstrap installation tests, install Multipass first and then run a VM-based profile:

```bash
./tests/test-in-vm.sh --platform ubuntu --image 24.04 --profile core
```

8. If you want to exercise cleanup or rollback flows end-to-end in a VM:

```bash
./tests/test-in-vm.sh --platform ubuntu --image 24.04 --profile full-clean
./tests/test-in-vm.sh --platform ubuntu --image 24.04 --profile full-rollback
```

## Operational Notes

- If you use `self-signed` TLS, it is useful to let the bootstrap update `/etc/hosts` and install local Docker trust for the registry certificate.
- In `--dry-run`, the script still inspects the current cluster and host state, but it does not apply changes.
- If you want registry auth, enable it during registry installation. The validator supports both modes:
  - anonymous
  - authenticated with `REGISTRY_USER` and `REGISTRY_PASSWORD`
- The managed path in this repository is `sudo k3s kubectl ...`. Use that unless you explicitly want a separate normal-user `kubectl` workflow.
- If you do want `kubectl` and `helm` as a normal user, keep a valid `kubeconfig` in `~/.kube/config`. The bootstrap can now sync that file for you when standalone `kubectl` is installed.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a concise summary of the current feature set and recent structural changes.
