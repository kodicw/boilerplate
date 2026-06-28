# boilerplate

Project templates and a CLI tool (`create-project`) for scaffolding reproducible, Nix-backed projects.

## Philosophy

1. **Guidance over Gospel** — Every file is a starting point. Modify, rename, or delete to suit your needs.
2. **Reproducibility** — Nix flakes ensure every project starts with a deterministic environment.
3. **Security by Design** — Templates default to least-privilege patterns and no hardcoded secrets.

## Quick Start

```bash
# Scaffold a project directly from GitHub (no clone required)
nix run github:kodicw/boilerplate -- <template> [project-name]
nix run github:kodicw/boilerplate -- general my-app

# Or use nix flake init for template-only scaffolding
nix flake init -t github:kodicw/boilerplate#rust
nix flake init -t github:kodicw/boilerplate#general
```

From a local clone:

```bash
nix build
./result/bin/create-project rust my-app
./result/bin/create-project python
./result/bin/create-project nixos-module
```

## Available Templates

| Template | Description |
|----------|-------------|
| `general` | Language-agnostic starter with Nix dev shell |
| `rust` | Rust binary with fenix toolchain and Nix dev shell |
| `python` | Python project with uv/Hatch and ruff |
| `nixos-module` | NixOS service module skeleton |

Each template includes community health files (CONTRIBUTING, CODE_OF_CONDUCT, SECURITY, etc.) and a `flake.nix` that passes `nix flake check` out of the box.

## Development

```bash
nix develop          # Enter dev shell (rust-analyzer, clippy, nixfmt, statix)
nix flake check      # Run all checks
```

See [WORKFLOW.md](./WORKFLOW.md) for the structured AI-assisted development process.
See [CONTRIBUTING.md](./CONTRIBUTING.md) for code standards and engineering practices.
