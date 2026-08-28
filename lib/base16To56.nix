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

	# Округление до ближайшего младшего ниббла (сохраняет фазу сетки исходного цвета)
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

	# Универсальный mix с сохранением шага нибблов исходного цвета
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

	luminance = hex: let
		rgb = hexToRgb hex;
	in
		(rgb.r * 299 + rgb.g * 587 + rgb.b * 114) / 1000.0;
in
	rawColors:
		if builtins.hasAttr "accent" rawColors && (builtins.hasAttr "bg" rawColors.accent || builtins.hasAttr "dimmed" rawColors.accent)
		then rawColors
		else let
			base00 = "#${normalizeHex rawColors.base."00"}";
			base05 = "#${normalizeHex rawColors.base."05"}";
			base07 = "#${normalizeHex rawColors.base."07"}";

			isDarkTheme = (luminance base00) < 128.0;

			normalAccents = {
				red = "#${normalizeHex rawColors.base."08"}";
				orange = "#${normalizeHex rawColors.base."09"}";
				yellow = "#${normalizeHex rawColors.base."0A"}";
				green = "#${normalizeHex rawColors.base."0B"}";
				cyan = "#${normalizeHex rawColors.base."0C"}";
				blue = "#${normalizeHex rawColors.base."0D"}";
				purple = "#${normalizeHex rawColors.base."0E"}";
				magenta = "#${normalizeHex rawColors.base."0F"}";
			};

			genAccentGroup = name: hex: let
				# Фоновые цвета акцентов
				dimmed =
					mixQuantized hex base00 (
						if isDarkTheme
						then 0.40
						else 0.30
					);
				normal = hex;
				bright =
					mixQuantized hex (
						if isDarkTheme
						then base07
						else base00
					)
					0.40;

				# Текстовые цвета поверх акцентов (теперь тоже сохраняют маску #?6?6?6)
				onDimmed = mixQuantized base07 dimmed 0.20;
				onNormal =
					mixQuantized (
						if isDarkTheme
						then base00
						else base07
					)
					normal
					0.40;
				onBright = mixQuantized base00 bright 0.40;
			in {
				bg = {inherit dimmed normal bright;};
				fg = {
					dimmed = onDimmed;
					normal = onNormal;
					bright = onBright;
				};
			};

			processed = lib.mapAttrs genAccentGroup normalAccents;
		in {
			base = {
				"0" = base00;
				"1" = "#${normalizeHex rawColors.base."01"}";
				"2" = "#${normalizeHex rawColors.base."02"}";
				"3" = "#${normalizeHex rawColors.base."03"}";
				"4" = "#${normalizeHex rawColors.base."04"}";
				"5" = base05;
				"6" = "#${normalizeHex rawColors.base."06"}";
				"7" = base07;
			};

			accent = {
				bg = {
					normal = lib.mapAttrs (_: v: v.bg.normal) processed;
					dimmed = lib.mapAttrs (_: v: v.bg.dimmed) processed;
					bright = lib.mapAttrs (_: v: v.bg.bright) processed;
				};
				fg = {
					normal = lib.mapAttrs (_: v: v.fg.normal) processed;
					dimmed = lib.mapAttrs (_: v: v.fg.dimmed) processed;
					bright = lib.mapAttrs (_: v: v.fg.bright) processed;
				};
			};
		}
