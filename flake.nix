{
  description = "boilerplate — project templates for nix flake init";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ] (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.nixfmt-rfc-style
            pkgs.statix
          ];
        };
      }
    )
    // {
      templates = {
        general = {
          path = ./templates/general;
          description = "General-purpose, language-agnostic template";
        };
        rust = {
          path = ./templates/rust;
          description = "Rust binary project with Nix dev shell";
        };
        python = {
          path = ./templates/python;
          description = "Python project with uv/Hatch configuration";
        };
        go = {
          path = ./templates/go;
          description = "Go project with Nix dev shell";
        };
        nixos-module = {
          path = ./templates/nixos-module;
          description = "NixOS module template";
        };
      };
      defaultTemplate = self.templates.general;
    };
}
