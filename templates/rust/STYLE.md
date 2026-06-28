# Style Guide

Rust and Nix conventions for this project.

## Rust

### Formatting
- **Formatter:** `cargo fmt` — the `rustfmt.toml` is authoritative.
- Run before every commit: `cargo fmt -- --check`

### Linting
- **Clippy:** `cargo clippy -- -D warnings`
- Enforced lints (see `Cargo.toml`):

| Lint | Why |
|------|-----|
| `unwrap_used` | Use `expect("context")` or proper `Result` handling |
| `panic` | No panics in library code |
| `todo` | No committed TODOs |
| `dbg_macro` | No debug macros in committed code |
| `print_stdout` | Use `tracing` for structured logging |

### Error Handling
- No bare `unwrap()`. Use `expect("context")` or propagate with `?`.
- Use `anyhow::Result` for application code, `thiserror` for libraries.

### Imports
Group by: standard library → external crates → local modules.

```rust
use std::path::PathBuf;

use anyhow::Result;
use serde::Deserialize;

use crate::config::Settings;
```

### Testing
- Unit tests in `#[cfg(test)]` modules at the bottom of each source file.
- Name tests descriptively: `test_<function>_<scenario>`.

### Naming
- Types: `PascalCase`
- Functions, variables, modules: `snake_case`
- Constants: `SCREAMING_SNAKE_CASE`

## Nix

- **Formatter:** `nixfmt` (RFC-style). Never `nixpkgs-fmt`.
- **Linter:** `statix check .`
- **Inputs:** Pin to `nixos-unstable`. Use `follows` to deduplicate shared inputs.
- **No hardcoded secrets.** Ever.

## Git

- Follow [Conventional Commits](https://www.conventionalcommits.org/).
- Imperative mood, no capital first letter, no trailing period, max 72 chars.

```
feat(core): add authentication module
fix(parser): handle empty input gracefully
chore(nix): bump fenix input
```
