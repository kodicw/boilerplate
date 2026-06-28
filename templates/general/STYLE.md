# Style Guide

General conventions for this project.

## Nix

- **Formatter:** `nixfmt` (RFC-style). Never `nixpkgs-fmt`.
- **Linter:** `statix check .`
- **Inputs:** Pin to `nixos-unstable` by default.
- **No hardcoded secrets.** Ever.

## Git

- Follow [Conventional Commits](https://www.conventionalcommits.org/).
- Imperative mood, no capital first letter, no trailing period, max 72 chars.

```
feat(core): add new feature
fix(api): handle edge case
chore(nix): bump nixpkgs input
```
