# boilerplate

Project templates for scaffolding reproducible, Nix-backed projects via `nix flake init`.

## Philosophy

1. **Guidance over Gospel** — Every file is a starting point. Modify, rename, or delete to suit your needs.
2. **Reproducibility** — Nix flakes ensure every project starts with a deterministic environment.
3. **Security by Design** — Templates default to least-privilege patterns and no hardcoded secrets.

## Quick Start

```bash
# Initialize a project from a template
nix flake init -t github:kodicw/boilerplate#rust
nix flake init -t github:kodicw/boilerplate#python
nix flake init -t github:kodicw/boilerplate#general
nix flake init -t github:kodicw/boilerplate#nixos-module

# Default template (general)
nix flake init -t github:kodicw/boilerplate
```

After init, rename `my-project` references in `flake.nix`, `Cargo.toml`, `pyproject.toml`, etc. to match your actual project name.

## Available Templates

| Template | Description | Init command |
|----------|-------------|-------------|
| `general` | Language-agnostic starter with Nix dev shell | `nix flake init -t github:kodicw/boilerplate#general` |
| `rust` | Rust binary with fenix toolchain and Nix dev shell | `nix flake init -t github:kodicw/boilerplate#rust` |
| `python` | Python project with uv/Hatch and ruff | `nix flake init -t github:kodicw/boilerplate#python` |
| `go` | Go project with golangci-lint and Nix dev shell | `nix flake init -t github:kodicw/boilerplate#go` |
| `nixos-module` | NixOS service module skeleton | `nix flake init -t github:kodicw/boilerplate#nixos-module` |

Each template includes a `STYLE.md` with language-specific conventions, a `CONTRIBUTING.md`, and a `flake.nix` that works out of the box.

## Development

```bash
nix develop          # Enter dev shell (nixfmt, statix)
nix flake check      # Run all checks
```

See [WORKFLOW.md](./WORKFLOW.md) for the structured AI-assisted development process.
See [CONTRIBUTING.md](./CONTRIBUTING.md) for code standards and engineering practices.
