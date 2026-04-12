{...}: let
	#чистый набор цветов
	colors = import ./colors.nix;
	#тема определяет какие цвета использовать
	theme =
		import ./theme.nix {
			vars = {inherit colors;};
		};
in {
	inherit theme colors;
	# переменные
	userFullName = "Foxy_Chipher";
	userPassword = "$6$AntMCBLfJ4foukEM$UrkX24HXtg4oUToaOv6YNzoTigCoYX9CbbyY0pNRk6ZmVG/3StBux6gDWA1dWSIE490PF4Q/YFcVixA7gc8zy.";
	fontName = "FiraCode Nerd Font Mono";
	fontSize = 14;
	shell = "fish"; # fish zsh bash brush
	terminal = "kitty";
}
