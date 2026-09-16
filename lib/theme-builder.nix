#lib/theme-builder.nix
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

	# Загрузка опционального default.nix, если он существует по указанному пути
	loadDefaultConfig = path:
		if builtins.pathExists path
		then import path
		else {};

	# Базовый конфиг из корня themes/default.nix
	rootConfig = loadDefaultConfig (themesDir + "/default.nix");

	# Сканирование тем из корня и поддиректорий
	findThemes = dirPath: let
		entries = builtins.readDir dirPath;

		# 1. Темы из файлов в корне themes/
		rootColorFiles =
			lib.filterAttrs (
				fileName: type:
					type
					== "regular"
					&& lib.hasSuffix ".nix" fileName
					&& fileName != "default.nix"
					&& !(lib.hasPrefix "_" fileName)
			)
			entries;

		rootThemes =
			lib.mapAttrs' (
				fileName: _: let
					themeName = lib.removeSuffix ".nix" fileName;
				in
					lib.nameValuePair themeName {
						colorPath = dirPath + "/${fileName}";
						folderConfig = rootConfig;
					}
			)
			rootColorFiles;

		# 2. Темы из поддиректорий themes/имядиректории/
		subdirs = lib.filterAttrs (name: type: type == "directory" && !(lib.hasPrefix "_" name)) entries;

		subThemes =
			lib.concatMapAttrs (
				dirName: _: let
					subDirPath = dirPath + "/${dirName}";
					subEntries = builtins.readDir subDirPath;

					# Конфиг папки наследует rootConfig с переопределением в имядиректории/default.nix
					folderDefaultNix = loadDefaultConfig (subDirPath + "/default.nix");
					folderConfig = rootConfig // folderDefaultNix;

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
								inherit folderConfig;
							}
					)
					colorFiles
			)
			subdirs;
	in
		rootThemes // subThemes;

	foundThemes = findThemes themesDir;
	themeNames = builtins.attrNames foundThemes;

	loadTheme = name: let
		themeInfo = foundThemes.${name};
		rawThemeContent = import themeInfo.colorPath;

		# Корректное выделение цветов:
		# Если файл содержит ключ 'base' или 'accent', мы передаем его как есть[cite: 3, 11].
		# Если же файл содержит только прямые пары "00" = "...", обворачиваем его в { base = ...; }.
		colorsData =
			if builtins.isAttrs rawThemeContent && (builtins.hasAttr "base" rawThemeContent || builtins.hasAttr "accent" rawThemeContent)
			then rawThemeContent
			else {base = rawThemeContent;};

		# Опциональные переопределения в самом файле темы
		fileConfig =
			if builtins.isAttrs rawThemeContent
			then {
				defaultAccent = rawThemeContent.defaultAccent or null;
				themeFn = rawThemeContent.themeFn or null;
			}
			else {};

		# Приоритет акцента: Файл темы -> default.nix папки -> root default.nix -> дефолт по умолчанию
		finalDefaultAccent =
			if fileConfig.defaultAccent != null
			then fileConfig.defaultAccent
			else
				themeInfo.folderConfig.defaultAccent or {
					level = "normal";
					color = "red";
				};

		finalThemeFn =
			if fileConfig.themeFn != null
			then fileConfig.themeFn
			else themeInfo.folderConfig.themeFn or defaultThemeStyle;
	in {
		colors = mkColors colorsData;
		themeFn = finalThemeFn;
		defaultAccent = finalDefaultAccent;
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

		bgHex = finalTree.ui.bg or validatedColors.base."00";
		isDark = (luminance bgHex) < 0.2;
	in {
		colors = validatedColors;
		theme = finalTree;
		inherit isDark;
		accentLevel = finalAccentLevel;
		accentColor = finalAccentColor;
	};
}
