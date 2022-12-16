{ pkgs, lib, tree-sitter }:

self: super:

let
  generatedGrammars = pkgs.callPackage ./generated.nix {
    buildGrammar = pkgs.callPackage ../../tree-sitter/grammar.nix { };
  };

  generatedDerivations = pkgs.lib.filterAttrs (_: pkgs.lib.isDerivation) generatedGrammars;

  # add aliases so grammars from `tree-sitter` are overwritten in `withPlugins`
  # for example, for ocaml_interface, the following aliases will be added
  #   ocaml-interface
  #   tree-sitter-ocaml-interface
  #   tree-sitter-ocaml_interface
  builtGrammars = generatedGrammars // pkgs.lib.concatMapAttrs
    (k: v:
      let
        replaced = pkgs.lib.replaceStrings [ "_" ] [ "-" ] k;
      in
      {
        "tree-sitter-${k}" = v;
      } // pkgs.lib.optionalAttrs (k != replaced) {
        ${replaced} = v;
        "tree-sitter-${replaced}" = v;
      })
    generatedDerivations;

  allGrammars = pkgs.lib.attrValues generatedDerivations;

  # Usage:
  # pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [ p.c p.java ... ])
  # or for all grammars:
  # pkgs.vimPlugins.nvim-treesitter.withAllGrammars
  withPlugins =
    f: self.nvim-treesitter.overrideAttrs (_: {
      passthru.dependencies = map
        (grammar:
          let
            name = pkgs.lib.pipe grammar [
              pkgs.lib.getName

              # added in buildGrammar
              (pkgs.lib.removeSuffix "-grammar")

              # grammars from tree-sitter.builtGrammars
              (pkgs.lib.removePrefix "tree-sitter-")
              (pkgs.lib.replaceStrings [ "-" ] [ "_" ])
            ];
          in

          pkgs.runCommand "nvim-treesitter-${name}-grammar" { } ''
            mkdir -p $out/parser
            ln -s ${grammar}/parser $out/parser/${name}.so
          ''
        )
        (f (tree-sitter.builtGrammars // builtGrammars));
    });

  withAllGrammars = withPlugins (_: allGrammars);
in

{
  postPatch = ''
    rm -r parser
  '';

  passthru = {
    inherit builtGrammars allGrammars withPlugins withAllGrammars;

    tests.check-queries =
      let
        nvimWithAllGrammars = pkgs.neovim.override {
          configure.packages.all.start = [ withAllGrammars ];
        };
      in
      pkgs.runCommand "nvim-treesitter-check-queries"
        {
          nativeBuildInputs = [ nvimWithAllGrammars ];
          CI = true;
        }
        ''
          touch $out
          export HOME=$(mktemp -d)
          ln -s ${withAllGrammars}/CONTRIBUTING.md .

          nvim --headless "+luafile ${withAllGrammars}/scripts/check-queries.lua" | tee log

          if grep -q Warning log; then
            echo "Error: warnings were emitted by the check"
            exit 1
          fi
        '';
  };

  meta = (super.nvim-treesitter.meta or { }) // {
    license = pkgs.lib.licenses.asl20;
    maintainers = with pkgs.lib.maintainers; [ figsoda ];
  };
}
