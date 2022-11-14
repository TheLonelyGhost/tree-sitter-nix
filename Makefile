.PHONY: test

test:
	nix flake check
	nix build --dry-run '.#tree-sitter' && rm -f ./result
