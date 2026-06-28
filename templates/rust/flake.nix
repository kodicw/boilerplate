{
  description = "my-project — Rust project with Nix development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      fenix,
      flake-utils,
    }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" ] (
      system:
      let
        fenix-tools = fenix.packages.${system}.stable;
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            fenix-tools.rust-analyzer
            fenix-tools.rustfmt
            fenix-tools.clippy
            fenix-tools.minimal
            pkgs.nixfmt-rfc-style
            pkgs.statix
          ];

          inputsFrom = [ fenix-tools.minimal ];
        };
      }
    );
}
