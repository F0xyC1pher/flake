# lib/base16To56.nix
{lib}: let
	colorUtils = import ./colorUtils.nix {inherit lib;};
	inherit (colorUtils) normalizeHex mixQuantized luminance hexToRgb getContrastingFg;
in
	rawColors:
		if builtins.hasAttr "accent" rawColors && (builtins.hasAttr "bg" rawColors.accent || builtins.hasAttr "dimmed" rawColors.accent)
		then rawColors
		else let
			base00 = "#${normalizeHex rawColors.base."00"}";
			base01 = "#${normalizeHex rawColors.base."01"}";
			base02 = "#${normalizeHex rawColors.base."02"}";
			base03 = "#${normalizeHex rawColors.base."03"}";
			base04 = "#${normalizeHex rawColors.base."04"}";
			base05 = "#${normalizeHex rawColors.base."05"}";
			base06 = "#${normalizeHex rawColors.base."06"}";
			base07 = "#${normalizeHex rawColors.base."07"}";

			isCustomTheme = (lib.mod (hexToRgb base00).r 16) == 6;
			isDarkTheme = (luminance base00) < 0.2;

			mix = mixQuantized isCustomTheme;

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
				dimmedBg =
					mix hex base00 (
						if isDarkTheme
						then 0.45
						else 0.30
					);
				normalBg = hex;
				brightBg =
					mix hex (
						if isDarkTheme
						then base07
						else base00
					) (
						if isDarkTheme
						then 0.35
						else 0.45
					);

				dimmedFg = getContrastingFg dimmedBg base00 base07;
				normalFg = getContrastingFg normalBg base00 base07;
				brightFg = getContrastingFg brightBg base00 base07;
			in {
				bg = {
					dimmed = dimmedBg;
					normal = normalBg;
					bright = brightBg;
				};
				fg = {
					dimmed = dimmedFg;
					normal = normalFg;
					bright = brightFg;
				};
			};

			processed = lib.mapAttrs genAccentGroup normalAccents;
		in {
			# Двойной маппинг для 100% совместимости с ролями и классическим base16
			base = {
				"0" = base00;
				"00" = base00;
				"1" = base01;
				"01" = base01;
				"2" = base02;
				"02" = base02;
				"3" = base03;
				"03" = base03;
				"4" = base04;
				"04" = base04;
				"5" = base05;
				"05" = base05;
				"6" = base06;
				"06" = base06;
				"7" = base07;
				"07" = base07;

				"08" = normalAccents.red;
				"09" = normalAccents.orange;
				"0A" = normalAccents.yellow;
				"0B" = normalAccents.green;
				"0C" = normalAccents.cyan;
				"0D" = normalAccents.blue;
				"0E" = normalAccents.purple;
				"0F" = normalAccents.magenta;
			};

			accent = {
				bg = {
					dimmed = lib.mapAttrs (_: v: v.bg.dimmed) processed;
					normal = lib.mapAttrs (_: v: v.bg.normal) processed;
					bright = lib.mapAttrs (_: v: v.bg.bright) processed;
				};
				fg = {
					dimmed = lib.mapAttrs (_: v: v.fg.dimmed) processed;
					normal = lib.mapAttrs (_: v: v.fg.normal) processed;
					bright = lib.mapAttrs (_: v: v.fg.bright) processed;
				};
			};
		}
