# lib/mkTheme.nix
{lib, ...}: let
	themesDir = ../themes;
	base16Convert = import ./base16To56.nix {inherit lib;};
	colorUtils = import ./colorUtils.nix {inherit lib;};
	defaultThemeStyle = import ./defaultThemeStyle.nix;

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

	# Рекурсивный поиск исключительно *.nix файлов тем
	findThemes = prefix: dirPath: let
		entries = builtins.readDir dirPath;

		# 1. Берем все *.nix файлы в текущей папке (игнорируем служебные с '_')
		nixFiles =
			lib.filterAttrs (
				name: type:
					type
					== "regular"
					&& lib.hasSuffix ".nix" name
					&& !(lib.hasPrefix "_" name)
			)
			entries;

		fileThemes =
			lib.mapAttrs' (
				fileName: _: let
					baseName = lib.removeSuffix ".nix" fileName;
					# Если тема лежит в подпапке, добавляем префикс "папка-"
					fullThemeName =
						if prefix == ""
						then baseName
						else "${prefix}-${baseName}";
				in
					lib.nameValuePair fullThemeName (dirPath + "/${fileName}")
			)
			nixFiles;

		# 2. Обходим все поддиректории
		subdirs = lib.filterAttrs (name: type: type == "directory" && !(lib.hasPrefix "_" name)) entries;

		subdirThemes =
			lib.concatMapAttrs (
				dirName: _: let
					nextPrefix =
						if prefix == ""
						then dirName
						else "${prefix}-${dirName}";
				in
					findThemes nextPrefix (dirPath + "/${dirName}")
			)
			subdirs;
	in
		fileThemes // subdirThemes;

	foundThemes = findThemes "" themesDir;
	themeNames = builtins.attrNames foundThemes;

	loadTheme = name: let
		themePath = foundThemes.${name};
		rawColors = import themePath;

		defaultAccent =
			if builtins.isAttrs rawColors && builtins.hasAttr "defaultAccent" rawColors
			then rawColors.defaultAccent
			else {
				level = "normal";
				color = "red";
			};
	in {
		colors = base16Convert rawColors;
		themeFn = defaultThemeStyle;
		inherit defaultAccent;
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
		selected = themes.${name} or (throw "Unknown theme: ${name}. Available themes: ${lib.concatStringsSep ", " themeNames}");
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
		isDark = (luminance bgHex) < 0.2;
	in {
		colors = validatedColors;
		theme = finalTree;
		inherit isDark;
		accentLevel = finalAccentLevel;
		accentColor = finalAccentColor;
	};
}
