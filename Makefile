NIX := nix
STATIX := statix

.PHONY: test
test:
	$(STATIX) check
	$(NIX) flake check
	$(NIX) build --dry-run '.#tree-sitter' && rm -f ./result
