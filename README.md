# Productive K3S

Productive K3S is the public entry point for the Productive K3S ecosystem.

The ecosystem is built around a simple idea: make lightweight Kubernetes easier to understand, install, operate, and extend without turning every use case into a different product.

This repository focuses on the public surface of that ecosystem:

- ecosystem positioning
- repository map and boundaries
- quickstart paths
- public roadmap
- documentation entry points

## Documentation

- Public documentation: [productive-k3s.io](https://productive-k3s.io/)
- Ecosystem overview: [docs/ecosystem](./docs/src/en/ecosystem/index.md)
- Quickstarts: [docs/quickstarts](./docs/src/en/quickstarts/index.md)
- Roadmap: [docs/roadmap](./docs/src/en/roadmap/index.md)

## Ecosystem components

- [`productive-k3s-core`](https://github.com/productive-k3s/productive-k3s-core): core runtime and installation engine
- [`productive-k3s-infra`](https://github.com/productive-k3s/productive-k3s-infra): infrastructure runtime engine, packaging, and automation
- `productive-k3s-profiles`: public profile/scenario source content
- [`productive-k3s-cli`](https://github.com/productive-k3s/productive-k3s-cli): unified command-line experience across the ecosystem
- [`productive-k3s-addons`](https://github.com/productive-k3s/productive-k3s-addons): optional extensions, examples, and non-core integrations
- `productive-k3s-profiles-pro`: private/commercial infrastructure layer

## Local docs

```bash
make docs-build
make docs-up
```

The generated site is published to `https://productive-k3s.io/`.
