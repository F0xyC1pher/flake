# mkTheme.nix — match выбирается из accent.* по близости оттенка к accent_hue+120
{lib}: let
	themesDir = ../modules/themes;

	# helpers
	absVal = x:
		if x < 0
		then -x
		else x;
	maxVal = a: b:
		if a > b
		then a
		else b;
	minVal = a: b:
		if a < b
		then a
		else b;
	modFloat = x: y: x - y * builtins.floor (x / y);

	# hex conversion
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

	rgbToHex = {
		r,
		g,
		b,
	}: let
		toHex = x: let
			h = lib.toHexString x;
		in
			if builtins.stringLength h == 1
			then "0${h}"
			else h;
	in "#${toHex r}${toHex g}${toHex b}";

	# RGB -> HSL
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

	# функцию hslToRgb для полноты (может не понадобиться для выбора)
	hslToRgb = {
		h,
		s,
		l,
	}: let
		c = (1 - absVal (2 * l - 1)) * s;
		hPrime = h / 60;
		sector = builtins.floor hPrime;
		odd = sector - 2 * builtins.floor (sector / 2);
		x = c * (1 - absVal (odd - 1));
		m = l - c / 2;
		pair =
			if sector == 0
			then {
				r = c;
				g = x;
				b = 0;
			}
			else if sector == 1
			then {
				r = x;
				g = c;
				b = 0;
			}
			else if sector == 2
			then {
				r = 0;
				g = c;
				b = x;
			}
			else if sector == 3
			then {
				r = 0;
				g = x;
				b = c;
			}
			else if sector == 4
			then {
				r = x;
				g = 0;
				b = c;
			}
			else {
				r = c;
				g = 0;
				b = x;
			};
	in {
		r = builtins.floor ((pair.r + m) * 255);
		g = builtins.floor ((pair.g + m) * 255);
		b = builtins.floor ((pair.b + m) * 255);
	};

	# ---- выбор match среди accent-цветов ----
	# целевой оттенок = hue(accent) + 120 (mod 360)
	# среди всех значений colors.accent (аттрибутов) выбираем тот, чей hue ближе к целевому
	# (можно также учитывать насыщенность/яркость, но для простоты только оттенок)
	hueDifference = h1: h2: let
		d = absVal (h1 - h2);
	in
		if d > 180
		then 360 - d
		else d;

	pickMatchFromAccents = accentHex: accentAttrs: let
		accentHsl = rgbToHsl (hexToRgb accentHex);
		targetHue = modFloat (accentHsl.h + 120) 360;
		# преобразуем attrset accentAttrs в список { name, hex, hsl }
		accentColors = builtins.attrNames accentAttrs;
		accentList =
			map (name: {
					inherit name;
					hex = accentAttrs.${name};
					hsl = rgbToHsl (hexToRgb accentAttrs.${name});
				})
			accentColors;
		# для каждого вычисляем разницу hue с targetHue
		withDiff = map (c: c // {diff = hueDifference c.hsl.h targetHue;}) accentList;
		# сортируем по возрастанию diff (можно использовать foldl для поиска минимума)
		best =
			builtins.foldl' (a: b:
					if b.diff < a.diff
					then b
					else a) (builtins.head withDiff) (builtins.tail withDiff);
	in
		best.hex;

	# ---- выбор onAccent среди base (самый контрастный по яркости) ----
	# простая ярность как среднее RGB
	luminance = hex: let
		rgb = hexToRgb hex;
		avg = (rgb.r + rgb.g + rgb.b) / (3.0 * 255.0);
	in
		avg;

	# из списка base цветов выбрать тот, чья яркость максимально далека от яркости фона
	pickOnAccentFromBase = bgHex: baseAttrs: let
		bgLum = luminance bgHex;
		baseColors = builtins.attrValues baseAttrs;
		# для каждого вычисляем разницу яркости (чем больше, тем контрастнее)
		withContrast =
			map (hex: {
					inherit hex;
					diff = absVal (luminance hex - bgLum);
				})
			baseColors;
		best =
			builtins.foldl' (a: b:
					if b.diff > a.diff
					then b
					else a) (builtins.head withContrast) (builtins.tail withContrast);
	in
		best.hex;

	# ---- остальное: валидация, автодискавери ----
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

	# ---- автообнаружение тем ----
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
	};

	themes = lib.genAttrs themeNames loadTheme;
in {
	inherit themes themeNames;
	resolve = {
		name,
		colorOverrides ? {},
		roleOverrides ? {},
	}: let
		selected = themes.${name} or (throw "Unknown theme: ${name}");
		mergedColors = lib.recursiveUpdate selected.colors colorOverrides;
		validatedColors = validateColors mergedColors;

		mappedTree =
			selected.themeFn {
				colors = validatedColors;
				lib = lib;
			};
		withUserOverrides = lib.recursiveUpdate mappedTree roleOverrides;

		accentColor = withUserOverrides.accent;

		# Выбираем match из accent-цветов темы (используя validatedColors.accent)
		matchColor =
			if (roleOverrides ? text && roleOverrides.text ? match)
			then roleOverrides.text.match
			else pickMatchFromAccents accentColor validatedColors.accent;

		# Выбираем onAccent из base-цветов темы
		onAccentColor =
			if (roleOverrides ? text && roleOverrides.text ? onAccent)
			then roleOverrides.text.onAccent
			else pickOnAccentFromBase accentColor validatedColors.base;

		finalTree =
			withUserOverrides
			// {
				text =
					withUserOverrides.text
					// {
						onAccent = onAccentColor;
						match = matchColor;
					};
			};
	in {
		colors = validatedColors;
		theme = finalTree;
	};
}
