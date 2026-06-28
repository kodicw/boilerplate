# Agent Instructions

You are working on **boilerplate** — a collection of Nix project templates used via `nix flake init`.

## Project Context

- This is a **template repository**, not an application.
- Templates live in `templates/<name>/` and are copied verbatim by `nix flake init`.
- The root `flake.nix` exposes `templates` and a minimal `devShells` output.
- There is no custom CLI, no build artifacts, no application code in the root.

## Key Files

- [WORKFLOW.md](./WORKFLOW.md) — The structured development process. **Follow this.**
- [CONTRIBUTING.md](./CONTRIBUTING.md) — Commit standards, branch strategy, how to add templates.
- [CHANGELOG.md](./CHANGELOG.md) — Record all notable changes here.

## Rules

1. **Commits:** Follow [Conventional Commits](https://www.conventionalcommits.org/). Scopes: `template`, `nix`, `docs`.
2. **Nix formatting:** `nixfmt` (RFC-style). Never `nixpkgs-fmt`.
3. **Nix linting:** `statix check .`
4. **No hardcoded secrets.** Ever.
5. **No placeholders.** Templates use real defaults (e.g., `my-project`). Users rename after init.
6. **Each template is self-contained.** It must pass `nix flake check` independently.
7. **Language-specific conventions** live in each template's `STYLE.md`, not here.
8. **Run `nix develop`** before any Nix or language-specific commands.

## Adding a New Template

1. Create `templates/<name>/` with at minimum: `flake.nix`, `README.md`, `CONTRIBUTING.md`, `CHANGELOG.md`, `STYLE.md`, `AGENTS.md` (+ symlinks).
2. Register in root `flake.nix` under `templates`.
3. Update root `README.md` template table.
4. Test: `nix flake init -t .#<name>` in a clean directory.
