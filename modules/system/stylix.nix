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
				vscode.enable = true;
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

		autoEnable = false;

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
			base00	=	vars.colors.b1;	# основной фон (editor, терминал, панели, tmux)
			base01	=	vars.colors.b2;	# лёгкий фон (статус-бары, tabline, folded код, вторичные панели)
			base02	=	vars.colors.b4;	# фон выделения текста (visual mode, selected text, поиск)
			
			# Серые тона для текста и неактивных элементов
			base03	=	vars.colors.b9;	# комментарии, невидимые символы, cursorline, неактивные элементы
			base04	=	vars.colors.ba;	# вторичный/приглушённый текст (statusline, git branch, метки, бордеры)
			
			# Основной и яркий текст
			base05	=	vars.colors.bd;	# основной цвет текста (обычный код, prompt в терминале)
			base06	=	vars.colors.be;	# bright foreground / special UI
			base07	=	vars.colors.bf;	# самый яркий белый (контрастный текст, bold/bright)
			
			# Акцентные цвета — семантика
			base08	=	vars.colors.r0;	# красный — ошибки, удалённое в diff, переменные, XML-теги, предупреждения
			base09	=	vars.colors.o0;	# оранжевый — числа, константы, escape-последовательности, пути/URL
			base0A	=	vars.colors.y0;	# жёлтый — классы, структуры, background поиска, WARN, иногда bold
			base0B	=	vars.colors.g0;	# зелёный — строки, добавленное в diff, успех
			base0C	=	vars.colors.c0;	# циан — типы, специальные конструкции, info, escape в строках
			base0D	=	vars.colors.b0;	# синий — функции, методы, ссылки, основной акцентный цвет
			base0E	=	vars.colors.p0;	# фиолетовый — ключевые слова, control flow, операторы, storage
			base0F	=	vars.colors.m0;	# пурпурный — deprecated, теги, вставки другого языка, спец-символы
			
			Scheme	=	"theme";
			slug	=	"theme";
			author	=	"FoxyChipher";
		};
	};
}
