{...}: let
	#чистый набор цветов
	# colors = import ./colors.nix;
	#тема определяет какие цвета использовать
	# theme =
	# 	import ./theme.nix {
	# 		vars = {inherit colors;};
	# 	};
in {
	# inherit theme colors;
	# переменные
	theme = "theme";
	# Optional — override raw palette values BEFORE the role mapping runs.
	# colorOverrides = {
	#   accent.red = "#ff2222";
	#   base."0"   = "#000000";
	# };

	# Optional — override resolved role tree AFTER mapping. Highest priority.
	# roleOverrides = {
	#   accent           = "#ffffff";
	#   ui.border.active = "#ffffff";
	# };
	userFullName = "Foxy_Chipher";
	userPassword = "$6$AntMCBLfJ4foukEM$UrkX24HXtg4oUToaOv6YNzoTigCoYX9CbbyY0pNRk6ZmVG/3StBux6gDWA1dWSIE490PF4Q/YFcVixA7gc8zy.";
	fontName = "FiraCode Nerd Font Mono";
	fontSize = 12;
	shell = "fish"; # fish zsh bash brush
	terminal = "kitty";
	blur.enable = true;
	blur.xray.enable = false;
}
