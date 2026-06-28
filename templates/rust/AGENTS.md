# Agent Instructions

You are working on a **Rust project** with a Nix dev shell.

## Key Files

- [STYLE.md](./STYLE.md) — Rust and Nix conventions. **Follow this.**
- [CONTRIBUTING.md](./CONTRIBUTING.md) — Commit standards and PR process.

## Rules

1. **Run `nix develop`** before any `cargo` commands. The Nix dev shell provides the Rust toolchain.
2. **Commits:** [Conventional Commits](https://www.conventionalcommits.org/).
3. **Formatting:** `cargo fmt` for Rust, `nixfmt` for Nix.
4. **Linting:** `cargo clippy -- -D warnings` and `statix check .`
5. **No `unwrap()`.** Use `expect("context")` or propagate with `?`.
6. **No hardcoded secrets.**
7. **Testing:** `cargo test` — write tests for new functionality.
8. **Validate:** Both `cargo clippy -- -D warnings` and `nix flake check` must pass.
