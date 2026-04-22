# ── Theming library ──────────────────────────────────────────────────────────
#
# Pure-Nix helper used by flake.nix at evaluation time to resolve a theme
# into the {colors, theme} pair that ends up in `vars.style`.
#
# Themes live in subdirectories of this folder:
#
#   modules/theming/<name>/colors.nix   — chaos zone (any color names)
#   modules/theming/<name>/theme.nix    — role tree (locked contract)
#
# Pipeline:
#   colors.nix  ──┐
#                 ├──▶ recursiveUpdate ◀── colorOverrides
#                 ▼
#            (effective colors)
#                 │
#                 ▼
#            theme.nix { colors = ... }
#                 │
#                 ▼
#            (mapped role tree) ──▶ recursiveUpdate ◀── roleOverrides
#                                          │
#                                          ▼
#                                      final theme
{lib}: let
	themesDir = ./.;
	themeNames = ["theme"];

	loadTheme = name: {
		colors = import (themesDir + "/${name}/colors.nix");
		themeFn = import (themesDir + "/${name}/theme.nix");
	};

	themes = lib.genAttrs themeNames loadTheme;
in {
	inherit themes themeNames;

	# resolve { name, colorOverrides, roleOverrides } → { colors, theme }
	resolve = {
		name,
		colorOverrides ? {},
		roleOverrides ? {},
	}: let
		selected = themes.${name} or
        (throw "theming: unknown theme \"${name}\". Available: ${lib.concatStringsSep ", " themeNames}");
		effectiveColors = lib.recursiveUpdate selected.colors colorOverrides;
		mappedTree = selected.themeFn {colors = effectiveColors;};
		finalTree = lib.recursiveUpdate mappedTree roleOverrides;
	in {
		colors = effectiveColors;
		theme = finalTree;
	};
}
