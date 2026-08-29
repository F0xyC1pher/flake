# lib/base16To56.nix
{lib}: let
	colorUtils = import ./colorUtils.nix {inherit lib;};
	inherit (colorUtils) normalizeHex mixQuantized luminance;
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
