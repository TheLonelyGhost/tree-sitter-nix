{
  description = "Treesitter Grammars in a box";
  inputs = {
    nixpkgs.url = "flake:nixpkgs";
    flake-utils.url = "flake:flake-utils";
    flake-compat.url = "github:edolstra/flake-compat";
    flake-compat.flake = false;
    overlays.url = "github:thelonelyghost/blank-overlay-nix";
  };

  outputs = { self, nixpkgs, flake-utils, flake-compat, overlays }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          # config.allowUnfree = true;
          overlays = [overlays.overlays.default];
        };

        tree-sitter = pkgs.callPackage ./tree-sitter {
          inherit (pkgs.darwin.apple_sdk.frameworks) Security;
        };

        vimPlugins = pkgs.callPackage ./neovim {
          inherit (pkgs.darwin.apple_sdk.frameworks) Security;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = [
            pkgs.bashInteractive
            pkgs.gnumake
          ];
          buildInputs = [
            # tree-sitter
            pkgs.nix-prefetch-git
            pkgs.jq
          ];
        };

        packages = {
          inherit (vimPlugins) nvim-treesitter;
          inherit tree-sitter;

          default = tree-sitter;
        };
      });
}
