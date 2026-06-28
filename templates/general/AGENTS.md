# Agent Instructions

You are working on a **general-purpose Nix project**.

## Key Files

- [STYLE.md](./STYLE.md) — Code conventions. **Follow this.**
- [CONTRIBUTING.md](./CONTRIBUTING.md) — Commit standards and PR process.

## Rules

1. **Run `nix develop`** before any commands.
2. **Commits:** [Conventional Commits](https://www.conventionalcommits.org/).
3. **Nix formatting:** `nixfmt` (RFC-style). Never `nixpkgs-fmt`.
4. **Nix linting:** `statix check .`
5. **No hardcoded secrets.**
6. **Validate:** `nix flake check` must pass before committing.
