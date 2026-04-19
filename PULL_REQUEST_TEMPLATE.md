## What

<!-- Provide a concise, one-sentence description of the change. -->

## Why

<!-- Why is this change necessary? Reference any related issues (e.g., Closes #123). -->

## How

<!-- Describe the technical implementation. How does this impact the NixOS configuration, Dockerfiles, or other infrastructure? -->

## Impact

- **NixOS**: Does this change any system services, firewall rules, or kernel parameters?
- **Docker/Containers**: Does this change any image definitions, volumes, network configurations, or resource limits?
- **Breaking Change**: Is this a breaking change for existing deployments?

## Checklist

- [ ] All new behavior is covered by a test (e.g., `nixosTest`, container smoke tests).
- [ ] `nix flake check` passes locally (if applicable).
- [ ] Code is formatted according to project standards (nixfmt, prettier, etc.).
- [ ] No hardcoded secrets (using Vault, env vars, or encrypted inputs).
- [ ] Documentation has been updated to reflect the changes.
- [ ] Pull request title follows [Conventional Commits](https://www.conventionalcommits.org/).

## Tests

<!-- Describe the tests you ran to verify your changes. -->
```bash
nix flake check
# or
nix build .#checks.x86_64-linux.integration
```
