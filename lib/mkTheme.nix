{lib, ...}: let
	themesDir = ../themes;
	base16Convert = import ./base16To56.nix {inherit lib;};
	# Вспомогательные функции для расчета HSL (сохранены без изменений)
	maxVal = a: b:
		if a > b
		then a
		else b;
	minVal = a: b:
		if a < b
		then a
		else b;
	absVal = x:
		if x < 0
		then -x
		else x;

	hexCharVal = ch:
		{
			"0" = 0;
			"1" = 1;
			"2" = 2;
			"3" = 3;
			"4" = 4;
			"5" = 5;
			"6" = 6;
			"7" = 7;
			"8" = 8;
			"9" = 9;
			"a" = 10;
			"b" = 11;
			"c" = 12;
			"d" = 13;
			"e" = 14;
			"f" = 15;
			"A" = 10;
			"B" = 11;
			"C" = 12;
			"D" = 13;
			"E" = 14;
			"F" = 15;
		}.${
			ch
		} or (throw "invalid hex digit ${ch}");

	hex2Dec = s: (hexCharVal (builtins.substring 0 1 s)) * 16 + hexCharVal (builtins.substring 1 1 s);

	# Функция конвертации HEX (#RRGGBB или RRGGBB) в набор { r, g, b }
	hexToRgb = hex: let
		clean =
			if builtins.substring 0 1 hex == "#"
			then builtins.substring 1 6 hex
			else hex;
	in {
		r = hex2Dec (builtins.substring 0 2 clean);
		g = hex2Dec (builtins.substring 2 2 clean);
		b = hex2Dec (builtins.substring 4 2 clean);
	};

	# Хелпер форматирования в строку "r, g, b" (полезно для Hyprland, GTK и CSS)
	hexToRgbString = hex: let
		rgb = hexToRgb hex;
	in "${toString rgb.r}, ${toString rgb.g}, ${toString rgb.b}";

	rgbToHsl = {
		r,
		g,
		b,
	}: let
		r' = r / 255.0;
		g' = g / 255.0;
		b' = b / 255.0;
		maxC = maxVal r' (maxVal g' b');
		minC = minVal r' (minVal g' b');
		delta = maxC - minC;
		hue =
			if delta == 0
			then 0
			else if maxC == r'
			then ((g' - b') / delta)
			else if maxC == g'
			then ((b' - r') / delta) + 2
			else ((r' - g') / delta) + 4;
		hueDeg = hue * 60;
		saturation =
			if maxC == 0
			then 0
			else delta / maxC;
		lightness = maxC;
	in {
		h =
			if hueDeg < 0
			then hueDeg + 360
			else hueDeg;
		s = saturation;
		l = lightness;
	};

	luminance = hex: let rgb = hexToRgb hex; in (rgb.r + rgb.g + rgb.b) / (3.0 * 255.0);

	hueDiff = h1: h2: let
		d = absVal (h1 - h2);
	in
		if d > 180
		then 360 - d
		else d;

	modFloat = x: y: x - y * builtins.floor (x / y);

	pickClosestByHue = targetHue: attrs: let
		items = builtins.attrNames attrs;
		withDiff =
			map (name: {
					inherit name;
					hex = attrs.${name};
					diff = hueDiff (rgbToHsl (hexToRgb attrs.${name})).h targetHue;
				})
			items;
		best =
			builtins.foldl' (a: b:
					if b.diff < a.diff
					then b
					else a) (builtins.head withDiff) (builtins.tail withDiff);
	in
		best.hex;

	validateColor = str:
		if ! builtins.isString str
		then throw "not a string"
		else if builtins.match "^#[0-9a-fA-F]{6}$" str == null
		then throw "invalid color ${str}"
		else str;

	validateColors = value:
		if builtins.isAttrs value
		then lib.mapAttrs (_: validateColors) value
		else if builtins.isList value
		then map validateColors value
		else if builtins.isString value && builtins.substring 0 1 value == "#"
		then validateColor value
		else value;
	opacityToHex = opacity: let
		validOpacity =
			if opacity > 1.0
			then 1.0
			else if opacity < 0.0
			then 0.0
			else opacity;
		decVal = builtins.floor (validOpacity * 255.0 + 0.5);
		hexDigits = "0123456789abcdef";
		d1 = builtins.substring (decVal / 16) 1 hexDigits;
		d2 = builtins.substring (lib.mod decVal 16) 1 hexDigits;
	in "${d1}${d2}";
	# Автообнаружение тем
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
		# Дефолтный акцент теперь структура { level; color; }
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

		# Определение итоговых значений уровня и цвета акцента
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

		# Проверка наличия ключей в объекте цветов
		_checkBg =
			if ! (builtins.hasAttr finalAccentLevel validatedColors.accent.bg && builtins.hasAttr finalAccentColor validatedColors.accent.bg.${finalAccentLevel})
			then throw "Theme ${name} has no accent.bg key '${finalAccentLevel}.${finalAccentColor}'"
			else true;

		_checkFg =
			if ! (builtins.hasAttr finalAccentLevel validatedColors.accent.fg && builtins.hasAttr finalAccentColor validatedColors.accent.fg.${finalAccentLevel})
			then throw "Theme ${name} has no accent.fg key '${finalAccentLevel}.${finalAccentColor}'"
			else true;

		# Вызов генератора темы с передачей обновленных акцентов
		mappedTree =
			selected.themeFn {
				colors = validatedColors;
				lib = lib;
				accentLevel = finalAccentLevel;
				accentColor = finalAccentColor;
			};

		# Исключаем служебные переопределения из roleOverrides при наложении
		cleanRoleOverrides = removeAttrs roleOverrides ["accentLevel" "accentColor" "accentName"];
		withUserOverrides = lib.recursiveUpdate mappedTree cleanRoleOverrides;

		# Динамический расчет цвета подсвечивания (match) на основе выбранного уровня
		accentHex = validatedColors.accent.bg.${finalAccentLevel}.${finalAccentColor};
		accentHsl = rgbToHsl (hexToRgb accentHex);
		targetMatchHue = modFloat (accentHsl.h + 120) 360;

		# Поиск ближайшего цвета среди ярких акцентов темы
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
		isDark = luminance bgHex < 0.5;
	in {
		colors = validatedColors;
		theme = finalTree;
		inherit isDark;
		accentLevel = finalAccentLevel;
		accentColor = finalAccentColor;
	};
}
