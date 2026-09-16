# lib/colors/math.nix
{
	lib,
	converters,
}: let
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

	luminance = hex: let
		rgb = converters.hexToRgb hex;
		calcChannel = c: let
			v = c / 255.0;
		in
			if v <= 0.04045
			then v / 12.92
			else let
				x = (v + 0.055) / 1.055;
			in
				x * x * (0.6 + 0.4 * x); # Точная аппроксимация степени 2.4
		r = calcChannel rgb.r;
		g = calcChannel rgb.g;
		b = calcChannel rgb.b;
	in
		0.2126 * r + 0.7152 * g + 0.0722 * b;

	getContrastingFg = bgHex: darkFg: lightFg:
		if (luminance bgHex) > 0.35
		then darkFg
		else lightFg;

	hueDiff = h1: h2: let
		d = absVal (h1 - h2);
	in
		if d > 180
		then 360 - d
		else d;

	modFloat = x: y: x - y * builtins.floor (x / y);

	quantize = val: baseVal: let
		baseInt = builtins.floor baseVal;
		phase = baseInt - (baseInt / 16) * 16;
		step = builtins.floor ((val - phase + 8) / 16.0);
		res = step * 16 + phase;
	in
		if res > 255
		then 255
		else if res < 0
		then 0
		else res;

	mixQuantized = useQuantize: c1Hex: c2Hex: weight: let
		rgb1 = converters.hexToRgb c1Hex;
		rgb2 = converters.hexToRgb c2Hex;
		w =
			if weight > 1.0
			then 1.0
			else if weight < 0.0
			then 0.0
			else weight;

		rawR = rgb1.r * (1.0 - w) + rgb2.r * w;
		rawG = rgb1.g * (1.0 - w) + rgb2.g * w;
		rawB = rgb1.b * (1.0 - w) + rgb2.b * w;
		roundVal = v: builtins.floor (v + 0.5);
	in
		converters.rgbToHex {
			r =
				if useQuantize
				then quantize rawR rgb1.r
				else roundVal rawR;
			g =
				if useQuantize
				then quantize rawG rgb1.g
				else roundVal rawG;
			b =
				if useQuantize
				then quantize rawB rgb1.b
				else roundVal rawB;
		};

	pickClosestByHue = targetHue: attrs: let
		items = builtins.attrNames attrs;
		withDiff =
			map (name: {
					inherit name;
					hex = attrs.${name};
					diff = hueDiff (converters.rgbToHsl (converters.hexToRgb attrs.${name})).h targetHue;
				})
			items;
		best =
			builtins.foldl' (
				a: b:
					if b.diff < a.diff
					then b
					else a
			) (builtins.head withDiff) (builtins.tail withDiff);
	in
		best.hex;
in {
	inherit
		absVal
		maxVal
		minVal
		luminance
		getContrastingFg
		hueDiff
		modFloat
		quantize
		mixQuantized
		pickClosestByHue
		;
}
