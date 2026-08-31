# lib/base16To56.nix
{lib}: let
	colorUtils = import ./colorUtils.nix {inherit lib;};
	inherit (colorUtils) normalizeHex mixQuantized luminance hexToRgb rgbToHex quantize;

	# Смешивание с опциональным квантованием
	mixSmart = useQuantize: c1Hex: c2Hex: weight: let
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

		roundVal = v: builtins.floor (v + 0.5);
	in
		rgbToHex {
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
in
	rawColors:
		if builtins.hasAttr "accent" rawColors && (builtins.hasAttr "bg" rawColors.accent || builtins.hasAttr "dimmed" rawColors.accent)
		then rawColors
		else let
			base00 = "#${normalizeHex rawColors.base."00"}";
			base05 = "#${normalizeHex rawColors.base."05"}";
			base07 = "#${normalizeHex rawColors.base."07"}";

			# Проверяем, наша ли это авторская палитра (маска *6 в base00)
			isCustomTheme = (lib.mod (hexToRgb base00).r 16) == 6;
			isDarkTheme = (luminance base00) < 128.0;

			mix = mixSmart isCustomTheme;

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
				normal = hex;

				# Приглушённая плашка
				dimmed =
					mix hex base00 (
						if isDarkTheme
						then 0.45
						else 0.30
					);

				# Светлая плашка: подтягиваем к светлой базе с ощутимым шагом
				bright =
					mix hex (
						if isDarkTheme
						then base07
						else base00
					) (
						if isDarkTheme
						then 0.35
						else 0.45
					);

				# Контекстный текст под соответствующий bg
				onDimmed =
					mix (
						if isDarkTheme
						then base07
						else base00
					)
					dimmed
					0.40;
				onNormal =
					mix (
						if isDarkTheme
						then base00
						else base07
					)
					normal
					0.35;
				onBright =
					mix (
						if isDarkTheme
						then base00
						else base07
					)
					bright
					0.45;
			in {
				bg = {inherit dimmed normal bright;};
				fg = {
					dimmed = onDimmed;
					normal = onNormal;
					bright = onBright;
				};
			};

			processed = lib.mapAttrs genAccentGroup normalAccents;

			collectAccents = targetGroup: targetLevel:
				lib.mapAttrs (_: v: v.${targetGroup}.${targetLevel}) processed;
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
					normal = collectAccents "bg" "normal";
					dimmed = collectAccents "bg" "dimmed";
					bright = collectAccents "bg" "bright";
				};
				fg = {
					normal = collectAccents "fg" "normal";
					dimmed = collectAccents "fg" "dimmed";
					bright = collectAccents "fg" "bright";
				};
			};
		}
