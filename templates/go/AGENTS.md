# Agent Instructions

You are working on a **Go project** with a Nix dev shell.

## Key Files

- [STYLE.md](./STYLE.md) — Go and Nix conventions. **Follow this.**
- [CONTRIBUTING.md](./CONTRIBUTING.md) — Commit standards and PR process.

## Rules

1. **Run `nix develop`** before any `go` commands. The Nix dev shell provides the Go toolchain.
2. **Commits:** [Conventional Commits](https://www.conventionalcommits.org/).
3. **Formatting:** `go fmt ./...` — non-negotiable.
4. **Linting:** `golangci-lint run` and `statix check .`
5. **Always check errors.** Never discard with `_`.
6. **Wrap errors:** `fmt.Errorf("context: %w", err)`
7. **Logging:** Use `log/slog`, not `fmt.Println` for operational output.
8. **No hardcoded secrets.**
9. **Testing:** `go test ./...` — use table-driven tests. Run `go test -race ./...` for concurrency.
10. **Validate:** Both `golangci-lint run` and `nix flake check` must pass.
