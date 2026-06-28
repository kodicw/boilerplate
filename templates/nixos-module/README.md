# my-module

A NixOS module.

## Usage

Import this module in your NixOS configuration:

```nix
{ imports = [ ./path/to/this/module ]; }
```

Then enable the service:

```nix
services.my-module.enable = true;
```

## Development

```bash
nix flake check      # Evaluate and test
nixfmt default.nix   # Format
statix check .       # Lint
```

See [STYLE.md](./STYLE.md) for module conventions.
