# WORKFLOW.md — Structured LLM Programming Workflow

> A disciplined, top-down development process designed to maintain architectural control, prevent AI-generated technical debt, and ensure code quality across Nix-based projects.

## Core Philosophy

The human developer remains the **primary architect**. The LLM is an assistant for grunt work — scaffolding, boilerplate, and systematic edits. If any phase produces incorrect artifacts (data structures, interfaces, or task lists), the workflow **halts immediately** for manual correction.

---

## Environment Prerequisite: Nix Dev Shell

**All development commands run inside `nix develop`.** Without it, toolchains are unavailable and linking fails.

```bash
# Enter the Nix dev shell (required before any build/lint/test command)
nix develop

# Or run one-off commands without entering the shell
nix develop --command <cmd>
```

The dev shell provides: `nixfmt-rfc-style` and `statix`.

---

## Phase 0: Research & Planning

**Objective:** Conduct initial research, map scope, and set clear requirements before touching code.

### Actions
1. Define the feature/change scope in plain language.
2. Identify which parts of the repo are affected (templates, root flake, docs).
3. Review existing conventions (see [Project Structure](#project-structure) and [Conventions](#conventions) below).
4. If the change touches Nix: read the relevant `flake.nix` (root or template-level) first.

### Gate
- Requirements are documented and unambiguous.
- The human has confirmed the scope before proceeding.

---

## Phase 1: Structure Definition

**Objective:** Establish the foundational data models, types, and configuration shapes.

### Actions
1. Prompt the LLM to define required data structures (Nix attrsets, template schemas).
2. For Nix changes: define the attribute structure (`inputs`, `outputs`, module options) before writing any implementation.

### Gate
- **Review, correct, and finalize all structures manually** before moving forward.
- Ensure types follow naming conventions (see [Conventions](#conventions)).

---

## Phase 2: Interface Stubs

**Objective:** Define boundaries and communication layers without implementation.

### Actions
1. Instruct the LLM to generate stubs and function signatures based on Phase 1 structures.
2. For Nix modules: define option declarations (`mkOption`, `mkEnableOption`) with types and descriptions, but with empty/trivial `config` blocks.
3. For templates: create the file tree with sensible defaults (e.g., `my-project`).

### Gate
- Stubs evaluate cleanly:
  ```bash
  nix flake check                      # Nix evaluates without errors
  ```
- Strict alignment with the architectural design from Phase 0.

---

## Phase 3: To-Dos

**Objective:** Map out the exact footprint of the changes across the codebase.

### Actions
1. Have the LLM locate **every** modification point and generate explicit `TODO` items.
2. Each TODO must reference a specific file, function, or Nix attribute.
3. Group TODOs by subsystem:
   - `templates/` — template file additions/modifications
   - `flake.nix` — root flake output changes
   - Docs — `README.md`, `CONTRIBUTING.md`, `WORKFLOW.md` updates

### Gate
- **Manually curate, verify, and prune** the TODO list.
- No orphaned references — every TODO traces back to a Phase 1 structure.

---

## Phase 4: Implement & Revert (Feedback Loop)

**Objective:** Stress-test the design without committing to the codebase.

### Actions
1. Let the LLM implement changes based on Phases 1–3.
2. Run the full validation suite:
   ```bash
   # Nix evaluation
   nix flake check

   # Formatting checks
   nixfmt --check flake.nix

   # Nix linting
   statix check .
   ```
3. **Crucial Step:** Revert all code changes after testing:
   ```bash
   git stash   # or git checkout -- .
   ```
4. Have the LLM analyze where it deviated from the plan or hit friction points.
5. Refine the approach based on the analysis.

### Gate
- All friction points are documented.
- The plan is updated before proceeding to final implementation.

---

## Phase 5: Invariants

**Objective:** Secure codebase reliability and define logical boundaries.

### Actions
1. Define and inject constraints, guardrails, and invariant checks:
   - **Nix:** No hardcoded secrets. Use `nixfmt-rfc-style` (never `nixpkgs-fmt`). `statix check .` must pass.
   - **Templates:** All template files must use `my-project` as the default project name.
2. Ensure template output is self-contained — a generated project must `nix flake check` independently.

### Gate
- All invariants are codified (lints, checks, CI gates) — not just documented.

---

## Phase 6: Implementation

**Objective:** Finalization — apply the polished changes permanently.

### Actions
1. Execute the final code generation based on all previous phases.
2. Run the complete validation suite one final time (same as Phase 4 step 2).
3. Commit using [Conventional Commits](#commit-messages):
   ```bash
   git add -A
   git commit -m "<type>(<scope>): <subject>"
   ```
4. Verify the template works end-to-end:
   ```bash
   nix flake init -t .#<template>
   # or test in a temp dir
   ```

### Gate
- All checks pass. Code is production-ready.

---

## Project Structure

```
.
├── templates/                # Project templates (copied verbatim on create)
│   ├── general/              # Language-agnostic starter
│   │   ├── flake.nix
│   │   ├── .gitignore
│   │   ├── README.md
│   │   ├── CHANGELOG.md
│   │   ├── CODE_OF_CONDUCT.md
│   │   ├── CONTRIBUTING.md
│   │   ├── GOVERNANCE.md
│   │   ├── ISSUE_TEMPLATE.md
│   │   ├── PULL_REQUEST_TEMPLATE.md
│   │   ├── SECURITY.md
│   │   └── SUPPORT.md
│   ├── rust/                 # Rust binary with Nix dev shell
│   │   ├── Cargo.toml
│   │   ├── rustfmt.toml
│   │   ├── flake.nix
│   │   └── src/main.rs
│   ├── python/               # Python project with uv/Hatch
│   │   └── pyproject.toml
│   └── nixos-module/         # NixOS module
│       └── default.nix
├── flake.nix                 # Root flake — exposes devShells and templates
├── flake.lock
├── README.md
├── CONTRIBUTING.md
├── WORKFLOW.md               # ← You are here
└── (community docs)          # CODE_OF_CONDUCT, GOVERNANCE, SECURITY, SUPPORT, etc.
```

## Conventions

### Nix Code Style
- **Formatter:** `nixfmt` (RFC-style). Never `nixpkgs-fmt`.
- **Linter:** `statix check .` — catches unnecessary `with`, deprecated builtins, redundant `let ... in`.
- **No hardcoded secrets.** Ever.
- **Inputs:** Pin to `nixos-unstable` by default. Use `follows` to deduplicate shared inputs where applicable.

### Rust Code Style (Templates)

> These conventions apply to **Rust-based template projects** (e.g., `templates/rust/`), not the boilerplate repo itself — the root repo contains no Rust code.

- **Formatting:** `cargo fmt` — default rustfmt configuration is authoritative.
- **Clippy:** `-D warnings` enforced. Warn on: `unwrap_used`, `panic`, `todo`, `dbg_macro`, `print_stdout`.
- **Error handling:** No bare `unwrap()`. Use `expect("context")` or proper `Result` propagation.
- **Imports:** Group by: standard library → external crates → local modules.
- **Tests:** Unit tests in `#[cfg(test)]` modules at the bottom of each source file.
- **Naming:** Types `PascalCase`, functions/variables/modules `snake_case`.

### Template Files
- Template files use `my-project` as a default name. Users rename after running `nix flake init`.
- When adding new templates:
  1. Include language-appropriate configuration files.
  2. Provide sensible defaults that pass `nix flake check` out of the box.
  3. Add template-specific documentation if behavior isn't obvious.

### Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <subject>

feat(cli): add python template support
fix(template): fix rust template clippy lints
chore(nix): bump nixpkgs input to 24.11
```

**Types:** `feat` `fix` `refactor` `test` `chore` `docs` `perf` `ci` `revert`
**Scopes:** `template` `nix` `docs` `ci`
**Subject rules:** imperative mood, no capital first letter, no trailing period, max 72 chars.

## Usage

```bash
# Initialize a project from a template
nix flake init -t github:kodicw/boilerplate#rust
nix flake init -t github:kodicw/boilerplate#python
nix flake init -t github:kodicw/boilerplate#general
nix flake init -t github:kodicw/boilerplate#nixos-module

# Default template (general)
nix flake init -t github:kodicw/boilerplate
```

After init, rename `my-project` references to match your actual project name.

## Key Design Decisions

- Templates are **static files** copied verbatim by `nix flake init`. No custom CLI, no code generation.
- The root `flake.nix` exposes `templates` (for `nix flake init -t`) and a minimal `devShells` for editing the repo.
- Template files use `my-project` as a default name — users rename after init.
- Multi-arch support via `flake-utils` in both the root flake and individual templates.
