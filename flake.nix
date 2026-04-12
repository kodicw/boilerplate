{
  description = "Nix project templates and create-project CLI";

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
    let
      templatesDir = ./templates;
    in
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (
      system:
      let
        fenix-tools = fenix.packages.${system}.stable;
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.default = self.packages.${system}.create-project;
        packages.create-project = pkgs.writeShellScriptBin "create-project" (import ./packages/create-project.nix {
            inherit pkgs;
            templatesPath = toString templatesDir;
          });

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
    )
    // {
      templates = {
        rust = {
          path = ./templates/rust;
          description = "Rust binary project with Nix dev shell";
        };
        python = {
          path = ./templates/python;
          description = "Python project with uv/Hatch configuration";
        };
        nixos-module = {
          path = ./templates/nixos-module;
          description = "NixOS module template";
        };
      };
      defaultTemplate = self.templates.rust;
    };
}
