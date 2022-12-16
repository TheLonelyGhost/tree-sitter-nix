{ pkgs, ... }:

self: super: {
  completion-treesitter = super.completion-treesitter.overrideAttrs (old: {
    dependencies = [
      self.completion-nvim
      self.nvim-treesitter
    ];
  });

  nvim-treesitter = super.nvim-treesitter.overrideAttrs (old:
    pkgs.callPackage ./nvim-treesitter/overrides.nix {
      tree-sitter = pkgs.callPackage ../tree-sitter { };
    } self super
  );

}
