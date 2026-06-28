# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed
- Renamed repository from `nix-project-templates` to `boilerplate`.
- Replaced `AGENTS.md` with `WORKFLOW.md` — structured LLM programming workflow.
- Refactored to use `nix flake init` exclusively — removed custom `create-project` CLI.
- Simplified root `flake.nix` — removed fenix dependency, packages output, and CLI script.
- Replaced `${PROJECT_NAME}` placeholders with `my-project` defaults (nix flake init copies verbatim).
- Root flake now supports all architectures (x86_64-linux, aarch64-linux, x86_64-darwin, aarch64-darwin).

### Added
- `WORKFLOW.md` — phased AI-assisted development workflow integrated with Nix tooling.

### Removed
- `AGENTS.md` — replaced by `WORKFLOW.md`.
- `packages/create-project.nix` — replaced by `nix flake init -t`.
- `fenix` input from root flake (individual templates carry their own toolchain inputs).

## [1.0.0] - 2026-04-11

### Added
- Initial release of `create-project` CLI tool.
- `general` template.
- `rust` template.
- `python` template.
- `nixos-module` template.
- Community health files: `CODE_OF_CONDUCT.md`, `SECURITY.md`, `SUPPORT.md`, `GOVERNANCE.md`, `CONTRIBUTING.md`, `PULL_REQUEST_TEMPLATE.md`, `ISSUE_TEMPLATE.md`.
