# Contributing Guide

**Project:** my-project  
**Version:** 0.1

---

## Getting Started

1. Fork and clone the repository.
2. Enter the development environment:
   ```bash
   nix develop
   ```
3. Create a feature branch:
   ```bash
   git checkout -b feat/my-feature
   ```

## Commit Messages

All commits follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <subject>
```

**Types:** `feat` `fix` `refactor` `test` `chore` `docs` `perf` `ci` `revert`  
**Subject rules:** imperative mood, no capital, no trailing period, max 72 chars.

### Examples

```
feat(core): add user authentication
fix(api): handle empty response body
chore(nix): bump nixpkgs input
```

## Code Style

### Nix
- Format with `nixfmt` (RFC-style). Never `nixpkgs-fmt`.
- Lint with `statix check .`
- No hardcoded secrets.

### General
- Run formatters and linters before committing.
- Write tests for new functionality.
- Keep changes focused — one concern per PR.

## Pull Request Process

1. Rebase on `main` before opening a PR.
2. Ensure all checks pass locally.
3. PR title follows Conventional Commits format.
4. Fill in the PR template.

## Community

- [Code of Conduct](./CODE_OF_CONDUCT.md)
- [Security Policy](./SECURITY.md)
- [Support](./SUPPORT.md)