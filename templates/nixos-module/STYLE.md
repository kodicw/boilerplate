# Style Guide

NixOS module conventions for this project.

## NixOS Modules

### Structure
- One module per file, or split into `options.nix` and `config.nix` for complex modules.
- Use `lib.mkEnableOption` for service toggles.
- Use `lib.mkOption` with explicit `type`, `default`, and `description` for every option.

### Option Naming
- Service options under `services.<name>`.
- Follow existing NixOS module conventions for consistency.

```nix
options.services.myservice = {
  enable = lib.mkEnableOption "myservice";

  port = lib.mkOption {
    type = lib.types.port;
    default = 8080;
    description = "Port to listen on.";
  };

  package = lib.mkOption {
    type = lib.types.package;
    default = pkgs.myservice;
    description = "The package to use.";
  };
};
```

### Systemd Services
- Use `lib.mkIf cfg.enable` to gate the entire config block.
- Set `Restart = "on-failure"` by default.
- Run as a dedicated user when possible (least privilege).
- Use `DynamicUser = true` for stateless services.

### Testing
- Use `nixosTest` for integration testing.
- Test that the service starts, listens on the correct port, and responds.

```nix
nixosTest {
  name = "myservice-test";
  nodes.machine = { ... }: {
    services.myservice.enable = true;
  };
  testScript = ''
    machine.wait_for_unit("myservice.service")
    machine.wait_for_open_port(8080)
  '';
}
```

## Nix

- **Formatter:** `nixfmt` (RFC-style). Never `nixpkgs-fmt`.
- **Linter:** `statix check .`
- **Inputs:** Pin to `nixos-unstable`.
- **No hardcoded secrets.** Ever. Use `agenix`, `sops-nix`, or environment files.

## Git

- Follow [Conventional Commits](https://www.conventionalcommits.org/).
- Imperative mood, no capital first letter, no trailing period, max 72 chars.

```
feat(module): add TLS support
fix(systemd): set correct restart policy
chore(nix): bump nixpkgs input
```
