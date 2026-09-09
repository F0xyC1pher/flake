{lib}: let
	colorUtils = import ./color-utils.nix {inherit lib;};
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

			# Генерация состояний active, inactive, disabled для базовых цветов
			genStates = hex: {
				active = hex;
				inactive =
					mix hex base00 (
						if isDarkTheme
						then 0.40
						else 0.25
					);
				disabled =
					mix hex base00 (
						if isDarkTheme
						then 0.65
						else 0.50
					);
			};

			# Генерация состояний для всех ключей base00..base07
			baseStateMap = {
				"00" = genStates base00;
				"01" = genStates base01;
				"02" = genStates base02;
				"03" = genStates base03;
				"04" = genStates base04;
				"05" = genStates base05;
				"06" = genStates base06;
				"07" = genStates base07;
			};

			# Распределение base00..base07 по ролям UI и Text согласно таблице
			baseUiMap = {
				bg = baseStateMap."00"; # Основной фон
				surface = baseStateMap."01"; # Дополнительный/альтернативный фон
				overlay = baseStateMap."02"; # Фон выделения текста, активная вкладка, разделители
				muted = baseStateMap."03"; # Неактивные элементы фона / заблокированный UI
				border = baseStateMap."04"; # Рамки, иконки, неактивные элементы интерфейса
			};

			baseTextMap = {
				comment = baseStateMap."03"; # Комментарии, заблокированный/неактивный текст
				dimmed = baseStateMap."04"; # Вторичный текст
				main = baseStateMap."05"; # Основной цвет текста (foreground)
				light = baseStateMap."06"; # Светлый текст высокого контраста
				heading = baseStateMap."07"; # Максимально контрастный текст
			};

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
			base = {
				"00" = base00;
				"01" = base01;
				"02" = base02;
				"03" = base03;
				"04" = base04;
				"05" = base05;
				"06" = base06;
				"07" = base07;

				"08" = normalAccents.red;
				"09" = normalAccents.orange;
				"0A" = normalAccents.yellow;
				"0B" = normalAccents.green;
				"0C" = normalAccents.cyan;
				"0D" = normalAccents.blue;
				"0E" = normalAccents.purple;
				"0F" = normalAccents.magenta;

				# Категоризированные цвета UI и TEXT по аналогии с accent
				ui = {
					active = lib.mapAttrs (_: v: v.active) baseUiMap;
					inactive = lib.mapAttrs (_: v: v.inactive) baseUiMap;
					disabled = lib.mapAttrs (_: v: v.disabled) baseUiMap;
				};
				text = {
					active = lib.mapAttrs (_: v: v.active) baseTextMap;
					inactive = lib.mapAttrs (_: v: v.inactive) baseTextMap;
					disabled = lib.mapAttrs (_: v: v.disabled) baseTextMap;
				};
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
