# Nix & Container Infrastructure Templates

**⚠️ IMPORTANT: This is a reference template, not a "turn-key" solution.**

This repository provides a set of high-quality templates and a CLI tool (`create-project`) for initializing infrastructure-as-code projects. It is designed as a **starting point and engineering guide** for building robust, declarative systems using NixOS, Docker, and modern CI/CD practices.

## Project Philosophy

1.  **Guidance over Gospel**: Every file in this repository is a suggestion. You are expected to modify, rename, or delete files to suit your specific architectural needs.
2.  **Infrastructure as Code**: Focus on reproducibility and declarative configuration at every layer.
3.  **Security by Design**: Patterns for least privilege, secret management, and sandboxing are included as defaults.

## Getting Started

To use these templates to kickstart a new project without cloning this repository:

```bash
# Usage: nix run github:kodicw/nix-project-templates -- <template> [project-name]
nix run github:kodicw/nix-project-templates -- general my-infrastructure
```

If you have the repository cloned locally:

```bash
nix run . -- general my-infrastructure
```

## Repository Structure

- `packages/`: Source for the `create-project` CLI tool.
- `templates/`: The actual project blueprints. Every template includes a full suite of community and infrastructure documents (`CODE_OF_CONDUCT.md`, `SECURITY.md`, etc.).
- `docs/`: Engineering standards and community health documents (meant to be adapted for your own repo).

## Customization Checklist

When initializing a new project from these templates, you should immediately review and update:
- [ ] **License headers**: Ensure they match your organization's requirements.
- [ ] **Contact info**: Update email placeholders in `SECURITY.md` and `CODE_OF_CONDUCT.md`.
- [ ] **Infrastructure settings**: Adjust NixOS options and Docker resource limits in the generated code.
- [ ] **CI/CD pipeline**: Update the flake checks to match your deployment target.

---
*This project is part of our internal infrastructure standardization efforts. Use it as a guide, but remember: you own the code you generate.*
