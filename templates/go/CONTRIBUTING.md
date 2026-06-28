# Contributing Guide

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

## Code Style

See [STYLE.md](./STYLE.md) for language-specific conventions.

## Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <subject>
```

**Types:** `feat` `fix` `refactor` `test` `chore` `docs` `perf` `ci` `revert`

## Pull Request Process

1. Rebase on `main` before opening a PR.
2. Ensure all checks pass locally.
3. PR title follows Conventional Commits format.
