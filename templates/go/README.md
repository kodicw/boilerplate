# my-project

A Go project.

## Getting Started

```bash
nix develop      # Enter dev shell (go, gopls, golangci-lint, delve)
go run .         # Run the project
go test ./...    # Run tests
```

## Development

```bash
go fmt ./...                     # Format code
golangci-lint run                # Lint
go test ./...                    # Test
go test -race ./...              # Test with race detector
go vet ./...                     # Static analysis
nixfmt flake.nix                 # Format Nix
statix check .                   # Lint Nix
```

## Build

```bash
go build -o my-project .
```

See [STYLE.md](./STYLE.md) for code conventions.
