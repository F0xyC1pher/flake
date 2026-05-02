{...}: {
	theme = "theme";
	# Optional — override raw palette values BEFORE the role mapping runs.
	colorOverrides = {
		accent.red = "#f67676";
	};

	# Optional — override resolved role tree AFTER mapping. Highest priority.
	roleOverrides = {
		accent = "#f67676";
		ui.border.active = "#f67676";
	};
	userFullName = "Foxy_Chipher";
	userPassword = "$6$AntMCBLfJ4foukEM$UrkX24HXtg4oUToaOv6YNzoTigCoYX9CbbyY0pNRk6ZmVG/3StBux6gDWA1dWSIE490PF4Q/YFcVixA7gc8zy.";
	fontName = "FiraCode Nerd Font Mono";
	fontSize = 12;
	shell = "fish"; # fish zsh bash brush
	terminal = "kitty";
	blur.enable = true;
	blur.xray.enable = false;
}
