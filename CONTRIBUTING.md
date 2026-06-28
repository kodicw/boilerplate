# Contributing Guide

**Project:** boilerplate  
**Version:** 2.0  
**Date:** 2026-06-28

---

## Table of Contents

1. [Commit Messages](#1-commit-messages)
2. [Branch Strategy](#2-branch-strategy)
3. [Code Style & Formatting](#3-code-style--formatting)
4. [Adding New Templates](#4-adding-new-templates)
5. [Pull Request Process](#5-pull-request-process)
6. [Community](#6-community)

---

## 1. Commit Messages

All commits follow the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) specification.

### Format

```
<type>(<scope>): <subject>

[optional body]

[optional footer(s)]
```

### Types

| Type | When to use |
|---|---|
| `feat` | A new template or feature |
| `fix` | A bug fix |
| `refactor` | Code restructuring with no behavior change |
| `test` | Adding or correcting tests only |
| `chore` | Nix flake updates, dependency bumps, tooling |
| `docs` | Documentation changes only |
| `perf` | Performance improvement |
| `ci` | Changes to CI/CD pipeline |
| `revert` | Reverts a previous commit |

### Scope

| Scope | Maps to |
|---|---|
| `template` | Template files in `templates/` |
| `nix` | `flake.nix` — root Nix expressions |
| `docs` | Documentation files |

Scope is optional but strongly encouraged. Omit it only for cross-cutting changes.

### Subject Rules

- Imperative mood, present tense: "add handler" not "added handler"
- No capital first letter
- No trailing period
- Maximum 72 characters for the full first line

### Examples

```
feat(template): add go template
fix(template): fix rust template clippy lints
refactor(nix): simplify flake outputs structure
chore(nix): bump nixpkgs input
docs: update template usage examples
```

### Body and Footers

Use the body to explain **why**, not what. The diff explains what.

```
fix(template): handle missing flake.lock gracefully

Previously, the template would fail nix flake check if
the lock file was not generated. Now it works out of the box.

Closes #42
```

Footer tokens:

| Token | Purpose |
|---|---|
| `Closes #N` | Links and closes a GitHub issue |
| `Refs #N` | References an issue without closing it |
| `BREAKING CHANGE:` | Documents a breaking change |

---

## 2. Branch Strategy

This project uses **trunk-based development** with short-lived feature branches. `main` is always in a releasable state.

### Branch Naming

```
<type>/<short-description>
```

Use the same type vocabulary as commit messages. Description is kebab-case, no more than 5 words.

```
feat/add-go-template
fix/rust-template-clippy
chore/bump-nixpkgs
docs/template-usage-guide
```

### Rules

- **Never commit directly to `main`.** All changes go through a PR.
- **One concern per branch.** A branch that fixes a bug and adds a template should be split.
- **Branches must be rebased on `main` before merge.**
- **Delete branches after merge.**

---

## 3. Code Style & Formatting

### Nix

All Nix files are formatted with `nixfmt` (the RFC-style formatter). Never `nixpkgs-fmt`.

```bash
nixfmt flake.nix templates/*/flake.nix
```

Check without modifying:

```bash
nixfmt --check flake.nix
```

Linting with `statix`:

```bash
statix check .
```

`statix` catches common Nix anti-patterns: unnecessary `with`, deprecated `builtins`, redundant `let ... in`.

### Template Files

- Template files use `my-project` as a default name. Users rename after running `nix flake init`.
- Each template must pass `nix flake check` independently when initialized in an empty directory.

---

## 4. Adding New Templates

When adding a new language/framework template:

1. Create a directory under `templates/<name>/`.
2. Include at minimum:
   - `flake.nix` — with a dev shell and appropriate tooling.
   - Community docs: `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `CHANGELOG.md`, `SECURITY.md`, `SUPPORT.md`, `GOVERNANCE.md`, `ISSUE_TEMPLATE.md`, `PULL_REQUEST_TEMPLATE.md`.
   - Language-appropriate config files (e.g., `Cargo.toml`, `pyproject.toml`).
3. Register the template in the root `flake.nix`:
   ```nix
   templates.<name> = {
     path = ./templates/<name>;
     description = "<description>";
   };
   ```
4. Use `my-project` as the default project name.
5. Ensure `nix flake init -t .#<name>` works in a clean directory.
6. Update `README.md` to add the template to the table.

### Validation Checklist

```bash
# Test in a temporary directory
cd $(mktemp -d)
nix flake init -t /path/to/boilerplate#<name>
nix flake check       # Must pass
nix develop           # Must enter shell without errors
```

---

## 5. Pull Request Process

### Opening a PR

1. Rebase on `main`:
   ```bash
   git fetch origin
   git rebase origin/main
   ```
2. Open the PR with a title that matches Conventional Commits:
   ```
   feat(template): add go template
   ```
3. Fill in the PR template.

### Review Checklist

- [ ] New templates pass `nix flake check` when initialized
- [ ] Nix expressions are formatted with `nixfmt`
- [ ] `statix check .` passes
- [ ] No hardcoded secrets
- [ ] Template is registered in root `flake.nix`
- [ ] README.md updated with new template
- [ ] Commit messages follow Conventional Commits

### Merge Strategy

All PRs are **squash-merged** into `main`.

---

## 6. Community

- **[Changelog](./CHANGELOG.md)**: Notable changes.
- **[Workflow](./WORKFLOW.md)**: Structured AI-assisted development process.