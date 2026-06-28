# Agent Instructions

You are working on a **NixOS module**.

## Key Files

- [STYLE.md](./STYLE.md) — NixOS module conventions. **Follow this.**
- [CONTRIBUTING.md](./CONTRIBUTING.md) — Commit standards and PR process.

## Rules

1. **Run `nix develop`** before any commands.
2. **Commits:** [Conventional Commits](https://www.conventionalcommits.org/).
3. **Nix formatting:** `nixfmt` (RFC-style). Never `nixpkgs-fmt`.
4. **Nix linting:** `statix check .`
5. **No hardcoded secrets.** Use `agenix`, `sops-nix`, or environment files.
6. **Options:** Use `lib.mkOption` with explicit `type`, `default`, and `description`.
7. **Services:** Gate with `lib.mkIf cfg.enable`. Use `DynamicUser = true` for stateless services.
8. **Testing:** Use `nixosTest` for integration tests.
9. **Validate:** `nix flake check` must pass before committing.
