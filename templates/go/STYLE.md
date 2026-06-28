# Style Guide

Go and Nix conventions for this project.

## Go

### Formatting
- **Formatter:** `go fmt ./...` — this is non-negotiable in Go.
- **Imports:** Use `goimports` (included in `gotools`).

### Linting
- **Linter:** `golangci-lint run`
- **Vet:** `go vet ./...`

### Error Handling
- Always check errors. Never discard with `_`.
- Wrap errors with context using `fmt.Errorf("doing x: %w", err)`.
- Use the `run()` pattern: `main()` calls `run() error`, then exits with code 1 on failure.

```go
if err := doSomething(); err != nil {
    return fmt.Errorf("doing something: %w", err)
}
```

### Logging
- Use `log/slog` for structured logging (stdlib, Go 1.21+).
- No `fmt.Println` for operational output — use `slog.Info`, `slog.Error`.
- `fmt.Println` is fine for user-facing CLI output.

### Naming
- Exported: `PascalCase`
- Unexported: `camelCase`
- Packages: short, lowercase, no underscores
- Interfaces: verb + `-er` suffix (e.g., `Reader`, `Stringer`)
- Avoid stuttering: `http.Client` not `http.HTTPClient`

### Project Layout
- Keep `main.go` minimal — delegate to `run()` or internal packages.
- Use `internal/` for private packages.
- Use `cmd/<name>/` if you have multiple binaries.

```
.
├── main.go
├── main_test.go
├── internal/
│   ├── config/
│   └── handler/
├── go.mod
├── go.sum
└── flake.nix
```

### Testing
- Tests live next to the code: `foo.go` → `foo_test.go`.
- Use table-driven tests for multiple cases.
- Use `t.Helper()` in test helpers.
- Run with race detector: `go test -race ./...`

```go
func TestAdd(t *testing.T) {
    tests := []struct {
        name     string
        a, b     int
        expected int
    }{
        {"positive", 1, 2, 3},
        {"zero", 0, 0, 0},
        {"negative", -1, -2, -3},
    }
    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            if got := Add(tt.a, tt.b); got != tt.expected {
                t.Errorf("Add(%d, %d) = %d, want %d", tt.a, tt.b, got, tt.expected)
            }
        })
    }
}
```

### Dependencies
- `go mod tidy` after adding/removing imports.
- Prefer stdlib. Only add dependencies when they provide significant value.

## Nix

- **Formatter:** `nixfmt` (RFC-style). Never `nixpkgs-fmt`.
- **Linter:** `statix check .`
- **No hardcoded secrets.** Ever.

## Git

- Follow [Conventional Commits](https://www.conventionalcommits.org/).
- Imperative mood, no capital first letter, no trailing period, max 72 chars.

```
feat(api): add health check endpoint
fix(handler): close response body
chore(deps): bump to go 1.23
```
