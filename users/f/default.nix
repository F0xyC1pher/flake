{...}: {
	theme = {
		name = "theMe";
		dark = true;
		# Optional — override raw palette values BEFORE the role mapping runs.
		# colorOverrides = {
		# 	accent.red = "#f67676";
		# };
		# Optional — override resolved role tree AFTER mapping. Highest priority.
		# roleOverrides = {
		# 	accent = "#f67676";
		# 	ui.border.active = "#f67676";
		# };

		font = {
			name = "FiraCode Nerd Font Mono";
			size = 12;
		};

		blur = {
			enable = true;
			xray.enable = false;
		};
	};
	user = {
		fullName = "Foxy_Chipher";
		password = "$6$AntMCBLfJ4foukEM$UrkX24HXtg4oUToaOv6YNzoTigCoYX9CbbyY0pNRk6ZmVG/3StBux6gDWA1dWSIE490PF4Q/YFcVixA7gc8zy.";
		shell = "fish"; # fish zsh bash brush
	};
	app = {
		browser = "firefox"; #firefox floorp zen ungoogled-chromium chrome
		file-manager = "yazi"; #yazi nautilus nemo
		launcher = "fuzzel"; #fuzzel rofi
		terminal = "kitty";
	};
}
