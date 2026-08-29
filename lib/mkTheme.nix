# lib/mkTheme.nix
{lib, ...}: let
	themesDir = ../themes;
	base16Convert = import ./base16To56.nix {inherit lib;};
	colorUtils = import ./colorUtils.nix {inherit lib;};

	inherit
		(colorUtils)
		hexToRgb
		hexToRgbString
		opacityToHex
		rgbToHsl
		luminance
		modFloat
		pickClosestByHue
		validateColors
		;

	entries = builtins.readDir themesDir;
	themeNames =
		lib.filter (
			name:
				entries.${name}
				== "directory"
				&& builtins.pathExists (themesDir + "/${name}/colors.nix")
				&& builtins.pathExists (themesDir + "/${name}/default.nix")
		) (builtins.attrNames entries);

	loadTheme = name: let
		rawColors = import (themesDir + "/${name}/colors.nix");
	in {
		colors = base16Convert rawColors;
		themeFn = import (themesDir + "/${name}/default.nix");
		defaultAccent =
			(import (themesDir + "/${name}/default.nix")).defaultAccent or {
				level = "normal";
				color = "red";
			};
	};

	themes = lib.genAttrs themeNames loadTheme;
in {
	inherit themes themeNames opacityToHex hexToRgb hexToRgbString;

	resolve = {
		name,
		colorOverrides ? {},
		roleOverrides ? {},
		accentLevel ? null,
		accentColor ? null,
	}: let
		selected = themes.${name} or (throw "Unknown theme: ${name}");
		mergedColors = lib.recursiveUpdate selected.colors colorOverrides;
		validatedColors = validateColors mergedColors;

		finalAccentLevel =
			if accentLevel != null
			then accentLevel
			else if (roleOverrides.accentLevel or null) != null
			then roleOverrides.accentLevel
			else selected.defaultAccent.level or "normal";

		finalAccentColor =
			if accentColor != null
			then accentColor
			else if (roleOverrides.accentColor or null) != null
			then roleOverrides.accentColor
			else selected.defaultAccent.color or "red";

		_checkBg =
			if !(builtins.hasAttr finalAccentLevel validatedColors.accent.bg && builtins.hasAttr finalAccentColor validatedColors.accent.bg.${finalAccentLevel})
			then throw "Theme ${name} has no accent.bg key '${finalAccentLevel}.${finalAccentColor}'"
			else true;

		_checkFg =
			if !(builtins.hasAttr finalAccentLevel validatedColors.accent.fg && builtins.hasAttr finalAccentColor validatedColors.accent.fg.${finalAccentLevel})
			then throw "Theme ${name} has no accent.fg key '${finalAccentLevel}.${finalAccentColor}'"
			else true;

		mappedTree =
			selected.themeFn {
				colors = validatedColors;
				inherit lib;
				accentLevel = finalAccentLevel;
				accentColor = finalAccentColor;
			};

		cleanRoleOverrides = removeAttrs roleOverrides ["accentLevel" "accentColor" "accentName"];
		withUserOverrides = lib.recursiveUpdate mappedTree cleanRoleOverrides;

		accentHex = validatedColors.accent.bg.${finalAccentLevel}.${finalAccentColor};
		accentHsl = rgbToHsl (hexToRgb accentHex);
		targetMatchHue = modFloat (accentHsl.h + 120) 360;

		matchColor = pickClosestByHue targetMatchHue validatedColors.accent.bg.bright;

		finalTree =
			withUserOverrides
			// {
				text =
					withUserOverrides.text
					// {
						match = matchColor;
						onAccent = withUserOverrides.text.onAccent or validatedColors.accent.fg.${finalAccentLevel}.${finalAccentColor};
					};
			};

		bgHex = finalTree.ui.bg or validatedColors.base."0";
		isDark = (luminance bgHex) < 128.0;
	in {
		colors = validatedColors;
		theme = finalTree;
		inherit isDark;
		accentLevel = finalAccentLevel;
		accentColor = finalAccentColor;
	};
}
