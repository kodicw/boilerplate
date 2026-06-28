# Support

Welcome! This document describes how to get help with boilerplate project templates.

## How to Get Support

### 1. Check Documentation

Before asking for help, please review:
- [README.md](./README.md) for usage instructions.
- [CONTRIBUTING.md](./CONTRIBUTING.md) for contribution standards.
- Template-specific files within each template directory.
- [NixOS Manual](https://nixos.org/manual/nixos/stable/)

### 2. Search Existing Issues

Search our [GitHub Issues](https://github.com/kodicw/boilerplate/issues) to see if your problem has already been addressed.

### 3. Open a Support Request

If you cannot find an answer, please open an issue:
- Use the **Bug Report** or **Feature Request** templates if applicable.
- For general questions, use the **Question** template.

## Template Support

Each template is designed to work with `nix flake init`. If you encounter issues:
1. Ensure you have a recent version of Nix with flakes enabled.
2. Try `nix flake init -t github:kodicw/boilerplate#<template>` in an empty directory.
3. Check that `nix flake check` passes in the initialized project.
