{
  description = "Treesitter Grammars in a box";
  inputs = {
    nixpkgs.url = "flake:nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";
    flake-compat.url = "github:edolstra/flake-compat";
    flake-compat.flake = false;
  };

  outputs = { self, nixpkgs, flake-utils, flake-compat }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          # config.allowUnfree = true;
        };

        tree-sitter = pkgs.callPackage ./tree-sitter {
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
          inherit tree-sitter;

          default = tree-sitter;
        };
      });
}
