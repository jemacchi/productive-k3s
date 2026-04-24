# Operations Docs

This folder contains practical how-tos and command references for the stack installed by this repository.

## Index

- [Reasons behind the stack](./reasons-behind.md)
- [Post-development testing guide](./post-development-testing.md)
- [Windows development guide](./windows-development.md)
- [Debian 13 supported platform](./debian-13-candidate.md)
- [Debian 12 supported platform](./debian-12-candidate.md)
- [GitHub Actions and release automation](./github-actions.md)
- [k3s checks](./k3s-checks.md)
- [Ingress checks](./ingress-checks.md)
- [Rancher checks](./rancher-checks.md)
- [Registry checks](./registry-checks.md)
- [Longhorn checks](./longhorn-checks.md)
- [Longhorn single-node notes](./longhorn-single-node-notes.md)
- [Certificate checks](./certificate-checks.md)

## Supported Matrix

The repository is validated and supported on:

- Ubuntu `24.04` LTS
- Ubuntu `22.04` LTS
- Debian `13` `trixie`
- Debian `12` `bookworm`

## Utilities

The repository also includes helper scripts under `utils/`:

- `utils/list-registry-images.sh`
- `utils/inspect-ingress.sh`
- `utils/inspect-rancher.sh`
- `utils/inspect-longhorn.sh`
- `utils/inspect-longhorn-volumes.sh`
