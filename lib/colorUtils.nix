# lib/color-utils.nix
{lib}: let
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

	dec2Hex = n: let
		val =
			if n > 255
			then 255
			else if n < 0
			then 0
			else n;
		hexDigits = "0123456789abcdef";
		d1 = builtins.substring (val / 16) 1 hexDigits;
		d2 = builtins.substring (lib.mod val 16) 1 hexDigits;
	in "${d1}${d2}";

	normalizeHex = hex:
		if builtins.substring 0 1 hex == "#"
		then builtins.substring 1 6 hex
		else hex;

	hexToRgb = hex: let
		clean = normalizeHex hex;
	in {
		r = hex2Dec (builtins.substring 0 2 clean);
		g = hex2Dec (builtins.substring 2 2 clean);
		b = hex2Dec (builtins.substring 4 2 clean);
	};

	rgbToHex = {
		r,
		g,
		b,
	}:
		"#" + (dec2Hex r) + (dec2Hex g) + (dec2Hex b);

	hexToRgbString = hex: let rgb = hexToRgb hex; in "${toString rgb.r}, ${toString rgb.g}, ${toString rgb.b}";

	opacityToHex = opacity: let
		validOpacity =
			if opacity > 1.0
			then 1.0
			else if opacity < 0.0
			then 0.0
			else opacity;
		decVal = builtins.floor (validOpacity * 255.0 + 0.5);
	in
		dec2Hex decVal;

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

	luminance = hex: let rgb = hexToRgb hex; in (rgb.r * 299 + rgb.g * 587 + rgb.b * 114) / 1000.0;

	hueDiff = h1: h2: let
		d = absVal (h1 - h2);
	in
		if d > 180
		then 360 - d
		else d;

	modFloat = x: y: x - y * builtins.floor (x / y);

	quantize = val: baseVal: let
		phase = lib.mod baseVal 16;
		step = builtins.floor ((val - phase + 8) / 16.0);
		res = step * 16 + phase;
	in
		if res > 255
		then 255
		else if res < 0
		then 0
		else res;

	mixQuantized = c1Hex: c2Hex: weight: let
		rgb1 = hexToRgb c1Hex;
		rgb2 = hexToRgb c2Hex;
		w =
			if weight > 1.0
			then 1.0
			else if weight < 0.0
			then 0.0
			else weight;

		rawR = rgb1.r * (1.0 - w) + rgb2.r * w;
		rawG = rgb1.g * (1.0 - w) + rgb2.g * w;
		rawB = rgb1.b * (1.0 - w) + rgb2.b * w;
	in
		rgbToHex {
			r = quantize rawR rgb1.r;
			g = quantize rawG rgb1.g;
			b = quantize rawB rgb1.b;
		};

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
		if !builtins.isString str
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
in {
	inherit
		absVal
		maxVal
		minVal
		hex2Dec
		dec2Hex
		normalizeHex
		hexToRgb
		rgbToHex
		hexToRgbString
		opacityToHex
		rgbToHsl
		luminance
		hueDiff
		modFloat
		quantize
		mixQuantized
		pickClosestByHue
		validateColor
		validateColors
		;
}
