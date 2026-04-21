# productive-k3s

Bootstrap and validation for a local `k3s` stack with:

- `cert-manager`
- `Longhorn`
- `Rancher`
- internal registry
- host NFS export

Recommended CLI usage:

- the scripts are designed to work with `sudo k3s kubectl`
- a standalone `kubectl` binary in your `PATH` is not required for the managed workflow in this repository
- Docker is not required for the stack itself; `k3s` uses `containerd` and that is enough for bootstrap, validation, and normal operation
- Docker is only needed for optional host-side workflows such as `test-in-docker.sh` and `validate-k3s-stack.sh --docker-registry-test`
- if you want a normal-user workflow for ad hoc commands, keep a valid `kubeconfig` in `~/.kube/config`
- the bootstrap logs this explicitly so users can tell whether `kubectl` was detected and whether that matters

## Scripts

### `bootstrap-k3s-stack.sh`

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

Usage:

```bash
./bootstrap-k3s-stack.sh
```

Dry-run:

```bash
./bootstrap-k3s-stack.sh --dry-run
```

### `validate-k3s-stack.sh`

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
./validate-k3s-stack.sh
```

Strict mode:

```bash
./validate-k3s-stack.sh --strict
```

JSON output:

```bash
./validate-k3s-stack.sh --json
```

Real registry validation with Docker:

Anonymous mode:

```bash
./validate-k3s-stack.sh --docker-registry-test
```

Authenticated mode:

```bash
REGISTRY_USER=registry REGISTRY_PASSWORD='your-password' ./validate-k3s-stack.sh --docker-registry-test
```

### `backup-k3s-stack.sh`

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
./backup-k3s-stack.sh
```

Custom output directory:

```bash
./backup-k3s-stack.sh /tmp/my-k3s-backup
```

### `rollback-k3s-stack.sh`

Builds a rollback plan from a bootstrap run manifest and can apply the safe subset of that rollback. It now includes extra teardown handling for Rancher/Fleet/Turtles and Longhorn cluster-scoped artifacts so namespaces are less likely to get stuck during removal.

Usage:

```bash
./rollback-k3s-stack.sh --to runs/bootstrap-...json --plan
./rollback-k3s-stack.sh --to runs/bootstrap-...json --apply
```

Notes:

- intended for manifest-guided rollback of what a specific bootstrap run introduced
- does not treat reused components as rollback targets
- leaves high-impact host actions such as removing `k3s` or `helm` as manual review in this first implementation

### `clean-k3s-stack.sh`

Fully destructive local cleanup helper for tearing down the stack. It includes extra cleanup for Rancher/Fleet/Turtles and Longhorn cluster-scoped resources to reduce teardown hangs.

Usage:

```bash
./clean-k3s-stack.sh --plan
./clean-k3s-stack.sh --apply
```

Notes:

- this is not manifest-guided rollback
- this is a broad cleanup tool intended to remove the local stack completely
- it prints a strong warning and requires explicit confirmation before applying
- it removes cluster resources and local integrations, but does not delete arbitrary user files inside Longhorn or NFS data directories

### `test-in-docker.sh`

Containerized smoke harness for testing the bootstrap in an isolated Ubuntu container. This is optional and requires Docker on the host.

Usage:

```bash
./test-in-docker.sh
```

Notes:

- this is a smoke-only harness
- it builds the test image and runs `bootstrap-k3s-stack.sh --dry-run` inside the container
- the Docker image build only prepares the environment
- the actual bootstrap smoke test happens at `docker run` time, not during `docker build`
- it validates the bootstrap flow, prompts, dry-run behavior, and run manifest generation
- it does not perform a real `k3s` installation inside the container

### `test-in-vm.sh`

Automated VM-based integration harness for real bootstrap testing. This requires Multipass on the host.

Usage:

```bash
./test-in-vm.sh --profile smoke
./test-in-vm.sh --profile core
./test-in-vm.sh --profile full
./test-in-vm.sh --profile full-clean
./test-in-vm.sh --profile full-rollback
```

Profiles:

- `smoke`
  - launches a clean VM
  - copies the repository
  - runs `bootstrap-k3s-stack.sh --dry-run`
- `core`
  - launches a clean VM
  - installs `k3s` and `helm`
  - skips optional components
  - waits for the VM state to settle
  - runs `validate-k3s-stack.sh --strict`
- `full`
  - launches a clean VM
  - installs the full stack with default answers
  - waits for the stack to settle
  - runs `validate-k3s-stack.sh --strict`
- `full-clean`
  - runs the `full` profile
  - runs `clean-k3s-stack.sh --apply` inside the VM
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

### `test-in-vm-cleanup.sh`

Cleanup helper for Multipass-based test VMs.

Usage:

```bash
./test-in-vm-cleanup.sh --name <vm-name>
./test-in-vm-cleanup.sh --all --purge
```

Notes:

- requires Multipass on the host
- `--all` only targets VMs whose name starts with `productive-k3s-test-`

## Recommended Flow

1. Install or reconcile:

```bash
./bootstrap-k3s-stack.sh
```

2. Validate:

```bash
./validate-k3s-stack.sh
```

3. Optionally validate the registry with Docker:

```bash
./validate-k3s-stack.sh --docker-registry-test
```

4. Export a configuration backup:

```bash
./backup-k3s-stack.sh
```

5. If needed, review a rollback plan for a specific bootstrap run:

```bash
./rollback-k3s-stack.sh --to runs/bootstrap-...json --plan
```

6. If you want an isolated smoke test of the bootstrap flow:

```bash
./test-in-docker.sh
```

7. If you want real bootstrap installation tests, install Multipass first and then run a VM-based profile:

```bash
./test-in-vm.sh --profile core
```

8. If you want to exercise cleanup or rollback flows end-to-end in a VM:

```bash
./test-in-vm.sh --profile full-clean
./test-in-vm.sh --profile full-rollback
```

## Operational Notes

- If you use `self-signed` TLS, it is useful to let the bootstrap update `/etc/hosts` and install local Docker trust for the registry certificate.
- In `--dry-run`, the script still inspects the current cluster and host state, but it does not apply changes.
- If you want registry auth, enable it during registry installation. The validator supports both modes:
  - anonymous
  - authenticated with `REGISTRY_USER` and `REGISTRY_PASSWORD`
- The managed path in this repository is `sudo k3s kubectl ...`. Use that unless you explicitly want a separate normal-user `kubectl` workflow.
- If you do want `kubectl` and `helm` as a normal user, keep a valid `kubeconfig` in `~/.kube/config`.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a concise summary of the current feature set and recent structural changes.
