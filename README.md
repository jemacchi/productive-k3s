# Productive K3S

Productive K3S is a pragmatic path to real Kubernetes without the usual pain.

It is designed for teams that need to start simple, keep the experience understandable, and grow modularly without rebuilding everything later.

This repository is the public product path for that ecosystem. It focuses on:

- ecosystem positioning
- conceptual model
- repository map and boundaries
- recommended ways to start
- public roadmap
- documentation hub

## Documentation

- Public documentation: [productive-k3s.io](https://productive-k3s.io/)
- Ecosystem overview: [docs/ecosystem](./docs/src/en/ecosystem/index.md)
- Quickstarts: [docs/quickstarts](./docs/src/en/quickstarts/index.md)
- Roadmap: [docs/roadmap](./docs/src/en/roadmap/index.md)

## Ecosystem components

- [`productive-k3s-core`](https://github.com/productive-k3s/productive-k3s-core): start with a real Kubernetes base in the simplest practical way
- [`productive-k3s-infra`](https://github.com/productive-k3s/productive-k3s-infra): deploy complete solutions on different platforms
- [`productive-k3s-profiles`](https://github.com/productive-k3s/productive-k3s-profiles): curated deployment solutions ready to use
- [`productive-k3s-cli`](https://github.com/productive-k3s/productive-k3s-cli): the simplest and recommended unified interface for the ecosystem
- [`productive-k3s-addons`](https://github.com/productive-k3s/productive-k3s-addons): curated packages for extending the cluster

## How the pieces fit

- `Core` can be used by itself when you want the most direct installation path.
- `Infra` builds on `Core` to deploy complete solutions across platforms.
- `Profiles` provide the curated solution paths that `Infra` executes.
- `Addons` provide curated cluster extensions that `Core` can install.
- `CLI` is the recommended interface across the ecosystem, but it is not mandatory.

## Local docs

```bash
make docs-build
make docs-up
```

The generated site is published to `https://productive-k3s.io/`.
