# Productive K3S

> Work in progress.

`productive-k3s` is the umbrella repository for the Productive K3S ecosystem.

Productive K3S is an opinionated ecosystem for building, installing, operating, and extending lightweight Kubernetes environments based on K3S.

This repository does not contain the core installation engine itself. Instead, it acts as the public entry point for the ecosystem: documentation, positioning, roadmap, repository map, examples of usage, and references to the different components.

## Ecosystem repositories

### `productive-k3s-core`

The core runtime and installation engine.

It contains the base K3S installation logic, supported core addons, cluster lifecycle scripts, local development utilities, and testing workflows.

This is the technical foundation of the ecosystem.

---

### `productive-k3s-infra`

Infrastructure automation and scenario assembly.

It contains profiles, use cases, OpenTofu, Ansible, `.env`-based configuration, overlays, and infrastructure-specific orchestration.

This repository defines how `productive-k3s-core` is used in concrete scenarios such as local development, edge deployments, ARM environments, observability setups, or other opinionated infrastructure cases.

---

### `productive-k3s-cli`

The user-facing command line interface.

It provides a unified UX over `productive-k3s-core` and `productive-k3s-infra`.

The CLI is expected to manage bundle resolution, installation flows, profile execution, diagnostics, and developer-friendly commands.

---

### `productive-k3s-infra-pro`

Private or commercial infrastructure profiles.

It extends `productive-k3s-infra` with monetizable, private, enterprise, or customer-specific profiles and automations.

This repository is intended for non-public use cases.

---

### `productive-k3s-addons`

Optional addon catalog.

It contains non-core addons, integrations, examples, experimental stacks, custom charts, and community-oriented components.

The goal is to let the ecosystem grow without increasing the maintenance burden of `productive-k3s-core`.

## Repository purpose

This repository is intended to contain:

- ecosystem documentation
- high-level architecture
- public roadmap
- repository map
- installation entry points
- comparison material
- quickstarts
- contribution guidelines
- release notes
- website or landing-page content

## Repository structure

```text
productive-k3s/
├── docs/
├── ecosystem/
├── roadmap/
├── quickstarts/
├── examples/
├── branding/
├── website/
└── .github/
```

## Status

This repository is currently a work in progress.

Names, conventions, structure, and repository boundaries may evolve as the ecosystem matures.

## License

This project uses the same license as `productive-k3s-core`.

See [LICENSE](./LICENSE).
