# Agent Instructions

You are working on a **Python project** with a Nix dev shell.

## Key Files

- [STYLE.md](./STYLE.md) — Python and Nix conventions. **Follow this.**
- [CONTRIBUTING.md](./CONTRIBUTING.md) — Commit standards and PR process.

## Rules

1. **Run `nix develop`** before any commands. The Nix dev shell provides Python and tooling.
2. **Commits:** [Conventional Commits](https://www.conventionalcommits.org/).
3. **Formatting:** `ruff format .` for Python, `nixfmt` for Nix.
4. **Linting:** `ruff check .` and `statix check .`
5. **Type hints:** Use type hints for all function signatures.
6. **No hardcoded secrets.**
7. **Testing:** `pytest` — write tests for new functionality.
8. **Dependencies:** Use `uv add <package>` to add, `uv sync` to install.
9. **Validate:** Both `ruff check .` and `nix flake check` must pass.
