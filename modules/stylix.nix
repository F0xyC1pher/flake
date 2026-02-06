# { stdenv, config, pkgs, lib, inputs, vars, ... }:
{ config, pkgs, lib, inputs, vars, ... }:
{
	home-manager.users.${vars.userName} = { config, pkgs, lib, ... }: {
		stylix.targets.qt.standardDialogs = "xdgdesktopportal";
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
				# standardDialogs = "xdgdesktopportal";
				# style = "kvantum";
			};
		};
		
		opacity.terminal = 0.8;
		
		fonts = {
			sizes.applications = 11;
			sizes.desktop = 11;
			sizes.terminal = 11;
			serif.name = "${vars.fontName}";
			monospace = config.stylix.fonts.serif;
			sansSerif = config.stylix.fonts.serif;
			emoji.name = "Noto Color Emoji";
		};
		
		base16Scheme = {
			# Фоны и основные поверхности
			base00	=	"#060606";	# основной фон (editor, терминал, панели, tmux)
			base01	=	"#363636";	# лёгкий фон (статус-бары, tabline, folded код, вторичные панели)
			base02	=	"#565656";	# фон выделения текста (visual mode, selected text, поиск)
			
			# Серые тона для текста и неактивных элементов
			base03	=	"#767676";	# комментарии, невидимые символы, cursorline, неактивные элементы
			base04	=	"#a6a6a6";	# вторичный/приглушённый текст (statusline, git branch, метки, бордеры)
			
			# Основной и яркий текст
			base05	=	"#d6d6d6";	# основной цвет текста (обычный код, prompt в терминале)
			base06	=	"#f6f6f6";	# bright foreground / special UI
			base07	=	"#f6f6f6";	# самый яркий белый (контрастный текст, bold/bright)
			
			# Акцентные цвета — семантика
			base08	=	"#d76667";	# красный — ошибки, удалённое в diff, переменные, XML-теги, предупреждения
			base09	=	"#ff6d66";	# оранжевый — числа, константы, escape-последовательности, пути/URL
			base0A	=	"#fed666";	# жёлтый — классы, структуры, background поиска, WARN, иногда bold
			base0B	=	"#67b766";	# зелёный — строки, добавленное в diff, успех
			base0C	=	"#61d6d6";	# циан — типы, специальные конструкции, info, escape в строках
			base0D	=	"#0666ff";	# синий — функции, методы, ссылки, основной акцентный цвет
			base0E	=	"#a666fd";	# фиолетовый — ключевые слова, control flow, операторы, storage
			base0F	=	"#fd66a6";	# пурпурный — deprecated, теги, вставки другого языка, спец-символы
			
			Scheme	=	"the-Me";
			slug	=	"the-Me";
			author	=	"FoxyChipher";
		};
	};
}
