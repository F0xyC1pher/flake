# lib/colors/converters.nix
{lib}: let
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
		then builtins.substring 1 (builtins.stringLength hex - 1) hex
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
		maxC =
			if r' > g'
			then
				(
					if r' > b'
					then r'
					else b'
				)
			else
				(
					if g' > b'
					then g'
					else b'
				);
		minC =
			if r' < g'
			then
				(
					if r' < b'
					then r'
					else b'
				)
			else
				(
					if g' < b'
					then g'
					else b'
				);
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
in {
	inherit
		hex2Dec
		dec2Hex
		normalizeHex
		hexToRgb
		rgbToHex
		hexToRgbString
		opacityToHex
		rgbToHsl
		;
}
