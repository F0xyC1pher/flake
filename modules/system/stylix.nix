{
	config,
	vars,
	...
}: {
	home-manager.users.${vars.userName} = {...}: {
		stylix = {
			polarity = "dark";
			targets = {
				micro.enable = true;
				vscode.enable = true;
				yazi.enable = true;
				nixcord.enable = true;
				fontconfig.enable = true;
				fish.enable = true;
				waybar.enable = false;
				nixos-icons.enable = true;
				mangohud.enable = true;
				fuzzel.enable = true;
				anki.enable = true;
				swaync.enable = true;
				qt = {
					enable = true;
					platform = "qtct";
					standardDialogs = "xdgdesktopportal";
				};
				gtk = {
					enable = true;
					flatpakSupport.enable = true;
					fonts.enable = true;
					extraCss = ''
						// syntax: css
						// Remove rounded corners
						* {
							border-radius: 0px;
							box-shadow: none;
						}

						.window-frame, .window-frame:backdrop {
							border-style: none;
							margin: 0;
						}

						.header-bar {
							background-image: none;
							background-color: ${vars.style.theme.surface3};
							box-shadow: none;
						}
						// You may want to use this if you do not like the double title.
						GtkLabel.title {
						    opacity: 0;
						}
					'';
				};
				firefox = {
					enable = true;
					colorTheme.enable = true;
					profileNames = ["${vars.userFullName}"];
				};
			};
		};
	};

	stylix = {
		enable = true;

		autoEnable = false;

		polarity = "dark";

		homeManagerIntegration = {
			autoImport = true;
			followSystem = true;
		};

		targets = {
			console.enable = true;
			fish.enable = true;
			qt = {
				enable = true;
				platform = "qtct";
			};
		};

		opacity.terminal = 0.6;

		fonts = {
			sizes = let
				s = vars.fontSize;
			in {
				applications = s;
				terminal = s;
				desktop = s;
				popups = s;
			};
			monospace.name = "${vars.fontName}";
			serif = config.stylix.fonts.monospace;
			sansSerif = config.stylix.fonts.monospace;
			emoji.name = "Noto Color Emoji";
		};

		base16Scheme = {
			# Фоны и основные поверхности
			base00 = vars.style.theme.bgMain; # основной фон (editor, терминал, панели, tmux)
			base01 = vars.style.theme.surface2; # лёгкий фон (статус-бары, tabline, folded код, вторичные панели)
			base02 = vars.style.theme.surface4; # фон выделения текста (visual mode, selected text, поиск)

			# Серые тона для текста и неактивных элементов
			base03 = vars.style.theme.subtext; # комментарии, невидимые символы, cursorline, неактивные элементы
			base04 = vars.style.theme.statusline; # вторичный/приглушённый текст (statusline, git branch, метки, бордеры)

			# Основной и яркий текст
			base05 = vars.style.theme.fgMain; # основной цвет текста (обычный код, prompt в терминале)
			base06 = vars.style.theme.brightText; # bright foreground / special UI
			base07 = vars.style.theme.contrastText; # самый яркий белый (контрастный текст, bold/bright)

			# Акцентные цвета — семантика
			base08 = vars.style.colors.r0; # красный — ошибки, удалённое в diff, переменные, XML-теги, предупреждения
			base09 = vars.style.colors.o0; # оранжевый — числа, константы, escape-последовательности, пути/URL
			base0A = vars.style.colors.y0; # жёлтый — классы, структуры, background поиска, WARN, иногда bold
			base0B = vars.style.colors.g0; # зелёный — строки, добавленное в diff, успех
			base0C = vars.style.colors.c0; # циан — типы, специальные конструкции, info, escape в строках
			base0D = vars.style.colors.b0; # синий — функции, методы, ссылки, основной акцентный цвет
			base0E = vars.style.colors.p0; # фиолетовый — ключевые слова, control flow, операторы, storage
			base0F = vars.style.colors.p1; # пурпурный — deprecated, теги, вставки другого языка, спец-символы

			Scheme = "theme";
			slug = "theme";
			author = "FoxyChipher";
		};
	};
}
