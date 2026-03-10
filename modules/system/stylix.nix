# { stdenv, config, pkgs, lib, inputs, vars, ... }:
{ config, pkgs, lib, inputs, vars, ... }:
{
	home-manager.users.${vars.userName} = { config, pkgs, lib, ... }: {
		# stylix = {
		# 	polarity = "dark";
		# 	targets.qt.standardDialogs = "xdgdesktopportal";
		# 	targets.micro.enable = true;
		# 	targets.waybar.enable = false;
		# };
		stylix = {
			polarity = "dark";
			targets = {
				micro.enable = true;
				kitty.enable = true;
				waybar.enable = false;
				qt ={
					enable = true;
					platform = "qtct";
					standardDialogs = "xdgdesktopportal";
				};
				firefox = {
					enable = true;
					profileNames = [ "${vars.userFullName}" ];
				};
			};
		};
	};
	
	stylix = {
	enable = true;
		
		polarity = "dark";
		
		homeManagerIntegration = {
			autoImport = true;
			followSystem = true;
		};
		
		targets = {
			qt ={
				enable = true;
				platform = "qtct";
			};
		};
		
		opacity.terminal = 0.8;
		
		fonts = {
			sizes = let s = vars.fontSize; in {
				applications	= s;
				desktop			= s;
				terminal		= s;
				popups			= s;
			};
			serif.name = "${vars.fontName}";
			monospace = config.stylix.fonts.serif;
			sansSerif = config.stylix.fonts.serif;
			emoji.name = "Noto Color Emoji";
		};
		
		base16Scheme = {
			# Фоны и основные поверхности
			base00	=	"#161616";	# основной фон (editor, терминал, панели, tmux)
			base01	=	"#363636";	# лёгкий фон (статус-бары, tabline, folded код, вторичные панели)
			base02	=	"#767676";	# фон выделения текста (visual mode, selected text, поиск)
			
			# Серые тона для текста и неактивных элементов
			base03	=	"#969696";	# комментарии, невидимые символы, cursorline, неактивные элементы
			base04	=	"#a6a6a6";	# вторичный/приглушённый текст (statusline, git branch, метки, бордеры)
			
			# Основной и яркий текст
			base05	=	"#d6d6d6";	# основной цвет текста (обычный код, prompt в терминале)
			base06	=	"#e6e6e6";	# bright foreground / special UI
			base07	=	"#f6f6f6";	# самый яркий белый (контрастный текст, bold/bright)
			
			# Акцентные цвета — семантика
			base08	=	vars.colors.red;	# красный — ошибки, удалённое в diff, переменные, XML-теги, предупреждения
			base09	=	vars.colors.orange;	# оранжевый — числа, константы, escape-последовательности, пути/URL
			base0A	=	vars.colors.yellow;	# жёлтый — классы, структуры, background поиска, WARN, иногда bold
			base0B	=	vars.colors.green;	# зелёный — строки, добавленное в diff, успех
			base0C	=	vars.colors.cyan;	# циан — типы, специальные конструкции, info, escape в строках
			base0D	=	vars.colors.blue;	# синий — функции, методы, ссылки, основной акцентный цвет
			base0E	=	vars.colors.purple;	# фиолетовый — ключевые слова, control flow, операторы, storage
			base0F	=	vars.colors.magenta;	# пурпурный — deprecated, теги, вставки другого языка, спец-символы
			
			Scheme	=	"theme";
			slug	=	"theme";
			author	=	"FoxyChipher";
		};
	};
}
