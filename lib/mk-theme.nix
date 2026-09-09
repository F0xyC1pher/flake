#lib/mk-theme.nix
{lib, ...}: let
	themesDir = ../themes;
	mkColors = import ./mk-colors.nix {inherit lib;};
	colorUtils = import ./color-utils.nix {inherit lib;};
	defaultThemeStyle = import ./default-theme-style.nix;

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

	# Поиск тем исключительно в поддиректориях
	findThemesInDirs = dirPath: let
		entries = builtins.readDir dirPath;

		# Фильтруем только поддиректории (игнорируем служебные с '_')
		subdirs = lib.filterAttrs (name: type: type == "directory" && !(lib.hasPrefix "_" name)) entries;

		# Обрабатываем каждую поддиректорию темы
		processDir = dirName: let
			subDirPath = dirPath + "/${dirName}";
			subEntries = builtins.readDir subDirPath;

			# Путь к default.nix с конфигурацией defaultAccent
			defaultNixPath = subDirPath + "/default.nix";

			# Загружаем defaultAccent из default.nix текущей поддиректории
			folderConfig =
				if builtins.pathExists defaultNixPath
				then import defaultNixPath
				else {};

			defaultAccent =
				folderConfig.defaultAccent or {
					level = "normal";
					color = "red";
				};

			# Все .nix файлы цветов внутри поддиректории (за исключением default.nix и '_*')
			colorFiles =
				lib.filterAttrs (
					fileName: type:
						type
						== "regular"
						&& lib.hasSuffix ".nix" fileName
						&& fileName != "default.nix"
						&& !(lib.hasPrefix "_" fileName)
				)
				subEntries;
		in
			lib.mapAttrs' (
				fileName: _: let
					baseName = lib.removeSuffix ".nix" fileName;
					themeName = "${dirName}-${baseName}";
				in
					lib.nameValuePair themeName {
						colorPath = subDirPath + "/${fileName}";
						inherit defaultAccent;
					}
			)
			colorFiles;
	in
		lib.concatMapAttrs (dirName: _: processDir dirName) subdirs;

	foundThemes = findThemesInDirs themesDir;
	themeNames = builtins.attrNames foundThemes;

	loadTheme = name: let
		themeInfo = foundThemes.${name};
		rawColors = import themeInfo.colorPath;
	in {
		colors = mkColors rawColors;
		themeFn = defaultThemeStyle;
		defaultAccent = themeInfo.defaultAccent;
	};

	themes = lib.genAttrs themeNames loadTheme;
in {
	inherit themes themeNames opacityToHex hexToRgb hexToRgbString;

	resolve = {
		name,
		accentLevel ? null,
		accentColor ? null,
	}: let
		selected = themes.${name} or (throw "Unknown theme: ${name}. Available themes: ${lib.concatStringsSep ", " themeNames}");
		validatedColors = validateColors selected.colors;

		finalAccentLevel =
			if accentLevel != null
			then accentLevel
			else selected.defaultAccent.level or "normal";

		finalAccentColor =
			if accentColor != null
			then accentColor
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

		accentHex = validatedColors.accent.bg.${finalAccentLevel}.${finalAccentColor};
		accentHsl = rgbToHsl (hexToRgb accentHex);
		targetMatchHue = modFloat (accentHsl.h + 120) 360;

		matchColor = pickClosestByHue targetMatchHue validatedColors.accent.bg.bright;

		finalTree =
			mappedTree
			// {
				text =
					mappedTree.text
					// {
						match = matchColor;
						onAccent = mappedTree.text.onAccent or validatedColors.accent.fg.${finalAccentLevel}.${finalAccentColor};
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
