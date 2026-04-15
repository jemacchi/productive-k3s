# productive-k3s

Bootstrap and validation for a local `k3s` stack with:

- `cert-manager`
- `Longhorn`
- `Rancher`
- internal registry
- host NFS export

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

- `kubectl get all -A`
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

## Recommended Flow

1. Install or reconcile:

```bash
./bootstrap-k3s-stack.sh
```

2. Validate:

```bash
./validate-k3s-stack.sh
```

3. Validate the registry with Docker:

```bash
./validate-k3s-stack.sh --docker-registry-test
```

4. Export a configuration backup:

```bash
./backup-k3s-stack.sh
```

## Operational Notes

- If you use `self-signed` TLS, it is useful to let the bootstrap update `/etc/hosts` and install local Docker trust for the registry certificate.
- If you want registry auth, enable it during registry installation. The validator supports both modes:
  - anonymous
  - authenticated with `REGISTRY_USER` and `REGISTRY_PASSWORD`
- To use `kubectl` and `helm` as a normal user, keep a valid `kubeconfig` in `~/.kube/config`.
