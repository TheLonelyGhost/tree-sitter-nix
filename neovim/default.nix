{ pkgs, ... }:

let
  inherit (pkgs.vimUtils.override {inherit (pkgs) vim;})
    buildVimPluginFrom2Nix vimGenDocHook vimCommandCheckHook;

  inherit (pkgs.lib) extends;

  initialPackages = self: { };

  plugins = pkgs.callPackage ./generated.nix {
    inherit (pkgs) buildVimPluginFrom2Nix;
    inherit (pkgs.neovimUtils) buildNeovimPluginFrom2Nix;
  };

  overrides = pkgs.callPackage ./overrides.nix {
    inherit (pkgs.darwin.apple_sdk.frameworks) Cocoa CoreFoundation CoreServices;
    inherit (pkgs) buildVimPluginFrom2Nix;
    inherit (pkgs) llvmPackages luaPackages;
  };

  extensible-self = pkgs.lib.makeExtensible
    (extends overrides
        (extends plugins initialPackages)
    );
in
  extensible-self
