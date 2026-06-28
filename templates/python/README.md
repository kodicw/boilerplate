# my-project

A Python project.

## Getting Started

```bash
nix develop      # Enter dev shell
uv sync          # Install dependencies
```

## Development

```bash
ruff format .                    # Format code
ruff check .                     # Lint
pytest                           # Test
nixfmt flake.nix                 # Format Nix
statix check .                   # Lint Nix
```

See [STYLE.md](./STYLE.md) for code conventions.
