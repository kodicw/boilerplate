# my-project

A Rust project.

## Getting Started

```bash
nix develop      # Enter dev shell (rust-analyzer, clippy, rustfmt)
cargo run        # Run the project
cargo test       # Run tests
```

## Development

```bash
cargo fmt                        # Format code
cargo clippy -- -D warnings      # Lint
cargo test                       # Test
nixfmt flake.nix                 # Format Nix
statix check .                   # Lint Nix
```

See [STYLE.md](./STYLE.md) for code conventions.
