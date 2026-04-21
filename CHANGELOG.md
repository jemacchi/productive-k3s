# Changelog

## Unreleased

### Added
- Incremental bootstrap for `k3s`, `helm`, `cert-manager`, `Longhorn`, `Rancher`, internal registry, host NFS export, `/etc/hosts`, and local Docker trust.
- Structured bootstrap run manifests under `runs/` for later inspection and manifest-guided rollback.
- `validate-k3s-stack.sh` with:
  - strict mode
  - JSON output
  - optional Docker registry push/pull validation
- `backup-k3s-stack.sh` for stack and host configuration export.
- `rollback-k3s-stack.sh` for safe manifest-guided rollback of bootstrap-introduced resources.
- `clean-k3s-stack.sh` for destructive full local stack cleanup.
- `test-in-docker.sh` as a smoke-only container harness for bootstrap `--dry-run`.
- `test-in-vm.sh` as the real integration harness using Multipass, with profiles:
  - `smoke`
  - `core`
  - `full`
  - `full-clean`
  - `full-rollback`
- `test-in-vm-cleanup.sh` for cleanup of Multipass-based test VMs.
- Host-side VM test artifacts under `test-artifacts/`, including copied bootstrap manifests when available.

### Changed
- Bootstrap UX was reorganized into:
  - detection
  - diagnosis
  - high-level decisions
  - plan
  - apply or dry-run
- Prompt labels now explicitly indicate whether a choice is:
  - required
  - optional
  - required for TLS-dependent installs
- Longhorn bootstrap no longer formats or mounts disks.
- Standalone `kubectl` is treated as optional; the managed workflow uses `sudo k3s kubectl`.
- Validator now treats absent optional components as skip conditions instead of implicit failures.
- VM-based tests now wait for validation to converge instead of assuming immediate readiness.

### Fixed
- Bootstrap prompt handling was stabilized for interactive terminals and non-TTY smoke tests.
- Bootstrap now waits for `cert-manager-webhook` endpoints and for Rancher/Registry certificates to become `Ready` before continuing.
- Longhorn default `StorageClass` handling was corrected to avoid multiple defaults in new installs.
- Rollback now resolves a usable kubeconfig before running helm-based cleanup.
- Rollback and clean teardown were hardened for:
  - Rancher/Fleet/Turtles namespaces and cluster-scoped artifacts
  - Longhorn webhook, CRD, `StorageClass`, and `CSIDriver` cleanup
- VM test profiles now persist artifacts and copied manifests on the host for later inspection.
