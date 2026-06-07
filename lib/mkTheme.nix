{lib, ...}: let
	themesDir = ../modules/themes;

	# Пользовательские min/max/abs
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

	# HEX conversion
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

	hexToRgb = hex: {
		r = hex2Dec (builtins.substring 1 2 hex);
		g = hex2Dec (builtins.substring 3 2 hex);
		b = hex2Dec (builtins.substring 5 2 hex);
	};

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

	loadTheme = name: {
		colors = import (themesDir + "/${name}/colors.nix");
		themeFn = import (themesDir + "/${name}/default.nix");
		defaultAccent = (import (themesDir + "/${name}/default.nix")).defaultAccent or "0";
	};

	themes = lib.genAttrs themeNames loadTheme;
in {
	inherit themes themeNames;

	resolve = {
		name,
		colorOverrides ? {},
		roleOverrides ? {},
		accentName ? null,
	}: let
		selected = themes.${name} or (throw "Unknown theme: ${name}");
		mergedColors = lib.recursiveUpdate selected.colors colorOverrides;
		validatedColors = validateColors mergedColors;

		finalAccentName =
			if accentName != null
			then accentName
			else if (roleOverrides.accentName or null) != null
			then roleOverrides.accentName
			else selected.defaultAccent;

		# Проверка существования ключей
		_check =
			if ! builtins.hasAttr finalAccentName validatedColors.accent
			then throw "Theme ${name} has no accent key '${finalAccentName}'"
			else if ! builtins.hasAttr finalAccentName validatedColors.onAccent
			then throw "Theme ${name} has no onAccent key '${finalAccentName}'"
			else true;

		mappedTree =
			selected.themeFn {
				colors = validatedColors;
				lib = lib;
				accentName = finalAccentName;
			};

		withUserOverrides = lib.recursiveUpdate mappedTree (removeAttrs roleOverrides ["accentName"]);

		accentHex = validatedColors.accent.${finalAccentName};
		accentHsl = rgbToHsl (hexToRgb accentHex);
		targetMatchHue = modFloat (accentHsl.h + 120) 360;
		matchColor = pickClosestByHue targetMatchHue validatedColors.accent;

		finalTree =
			withUserOverrides
			// {
				text =
					withUserOverrides.text
					// {
						match = matchColor;
						onAccent = withUserOverrides.text.onAccent or validatedColors.onAccent.${finalAccentName};
					};
			};

		bgHex = finalTree.ui.deep or validatedColors.base."0";
		isDark = luminance bgHex < 0.5;
	in {
		colors = validatedColors;
		theme = finalTree;
		inherit isDark finalAccentName;
	};
}
