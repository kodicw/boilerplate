# AGENTS.md — templates

This file is the authoritative reference for agentic coding agents operating in this repository.

## Build Commands

**Important:** All `cargo` commands must be run inside `nix develop` to ensure the Nix linker is available. Without it, linking fails with `ld-wrapper.sh: No such file or directory`.

```bash
# Enter the Nix dev shell (required for all cargo commands)
nix develop

# Compile the CLI
cargo build

# Type-check without building
cargo check

# Format Rust code (formatter is authoritative — never override manually)
cargo fmt

# Lint (warnings are errors)
cargo clippy -- -D warnings

# Unit tests (fast, no QEMU)
cargo test

# Single unit test
cargo test test_template_name_validation

# Full integration suite (if applicable)
nix flake check

# Nix formatting check
nixfmt --check flake.nix
```

Alternatively, run commands via `nix develop --command`:

```bash
nix develop --command cargo build
nix develop --command cargo test
```

## Project Structure

```
.
├── templates/               # Project templates
│   ├── rust/              # Rust binary template
│   │   ├── Cargo.toml
│   │   ├── rustfmt.toml
│   │   ├── flake.nix
│   │   └── src/main.rs
│   ├── python/            # Python project template
│   │   └── pyproject.toml
│   └── nixos-module/     # NixOS module template
│       └── default.nix
├── create-project/        # CLI tool source
│   ├── Cargo.toml
│   ├── flake.nix
│   └── src/main.rs
├── flake.nix             # Root flake (convenience wrapper)
├── CONTRIBUTING.md
└── AGENTS.md
```

## Rust Code Style (create-project CLI)

- **Formatting:** `cargo fmt` only. Use default rustfmt configuration.
- **Clippy:** `-D warnings` enforced. Explicitly warn on: `unwrap_used`, `panic`, `todo`, `dbg_macro`, `print_stdout`.
- **Logging:** Use `eprintln!` for errors, `println!` for user output. This is a CLI tool, not a long-running service.
- **Error handling:** No bare `unwrap()`. Use `expect("context")` for truly unrecoverable cases, or proper error handling.
- **Imports:** `use` statements grouped by standard library, external crates, local.
- **Tests:** Unit tests live in `#[cfg(test)]` modules at the bottom of each source file.
- **Naming:**
  - Types/structs/enums: `PascalCase`
  - Functions/methods: `snake_case`
  - Variables: `snake_case`
  - Module names: `snake_case`

## Nix Code Style

- **Formatter:** `nixfmt` (RFC-style). Never `nixpkgs-fmt`.
- **Linter:** `statix check .` (catches unnecessary `with`, deprecated builtins, redundant `let ... in`).
- **No hardcoded secrets.**

## Template Files

Template files use `${PROJECT_NAME}` and `${PROJECT_DESCRIPTION}` placeholders that get replaced during project creation. When adding new templates:

1. Use consistent placeholder names
2. Include appropriate configuration files
3. Provide sensible defaults
4. Document requirements in template-specific README if needed

### Available Templates

| Template | Description | Key Files |
|----------|-------------|------------|
| `rust` | Rust binary with Nix dev shell | `Cargo.toml`, `rustfmt.toml`, `flake.nix`, `src/main.rs` |
| `python` | Python project with uv/Hatch | `pyproject.toml` |
| `nixos-module` | NixOS module | `default.nix` |

## Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <subject>

feat(cli): add python template support
fix(template): fix rust template clippy lints
chore(nix): bump nixpkgs input to 24.11
```

Valid types: `feat fix refactor test chore docs perf ci revert`
Valid scopes: `cli template nix docs`

Subject rules: imperative mood, no capital first letter, no trailing period, max 72 chars.

## CLI Usage

```bash
# Build the CLI
nix build

# Or enter dev shell
nix develop

# Create a new project from a template
./result/bin/create-project rust my-app
./result/bin/create-project python
./result/bin/create-project nixos-module
```

## Key Design Decisions

- Templates are stored as static files that are copied verbatim during project creation.
- The CLI uses environment variable `CARGO_PKG_TEMPLATE_DIR` to locate templates at runtime.
- Template placeholders use `${VAR}` syntax for simple text replacement.
- The root `flake.nix` provides a convenience entry point but delegates to `create-project/flake.nix` for the actual package.