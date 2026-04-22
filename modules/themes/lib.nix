# ── Theming library ──────────────────────────────────────────────────────────
#
# Pure-Nix helper used by flake.nix at evaluation time to resolve a theme
# into the {colors, theme} pair that ends up in `vars.style`.
#
# Themes live in subdirectories of this folder, auto-discovered by name:
#
#   modules/theming/<name>/palette.nix   — chaos zone (any color names)
#   modules/theming/<name>/default.nix   — role tree (locked contract)
#
# Pipeline:
#   palette.nix ──┐
#                 ├──▶ recursiveUpdate ◀── colorOverrides
#                 ▼
#            (effective colors)
#                 │
#                 ▼
#            default.nix { colors = ... }
#                 │
#                 ▼
#            (mapped role tree) ──▶ recursiveUpdate ◀── roleOverrides
#                                          │
#                                          ▼
#                                      final theme
{lib}: let
	themesDir = ./.;

	# Auto-discover every subdirectory that contains both palette.nix and
	# default.nix. Folder name = theme name. No central registry to maintain.
	entries = builtins.readDir themesDir;
	themeNames =
		lib.filter
		(name:
				entries.${name}
				== "directory"
				&& builtins.pathExists (themesDir + "/${name}/colors.nix")
				&& builtins.pathExists (themesDir + "/${name}/default.nix"))
		(builtins.attrNames entries);

	loadTheme = name: {
		colors = import (themesDir + "/${name}/colors.nix");
		themeFn = import (themesDir + "/${name}/default.nix");
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
