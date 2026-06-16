{...}: {
	theme = {
		name = "attheMe";
		# dark = true;
		accent = "0";
		# gaps = 8;
		# border = 2;

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
			name = "Monocraft";
			size = 14;
		};

		blur = {
			enable = true;
			xray.enable = false;
		};
	};
	user = {
		fullName = "Foxy_Chipher";
		mail = "ageev-eldar@mail.ru";
		gitName = "FoxyChipher";
		password = "$6$AntMCBLfJ4foukEM$UrkX24HXtg4oUToaOv6YNzoTigCoYX9CbbyY0pNRk6ZmVG/3StBux6gDWA1dWSIE490PF4Q/YFcVixA7gc8zy.";
		shell = "fish"; # fish zsh bash brush
	};
	system = {
		modKey = "Mod4"; # Super
		desktopShell = "dms"; # custom dms noctalia
	};
	programs = [
		"firefox"
		"cli"
		"niri"
		"no-gnome"
		"xwayland"
		"dev"
		"gayming"
		"cursor" # вообще он должен быть всегда импортирован если есть окружение, типа он всегда нужен если ты не в tty
		"fonts"
		"fuzzel"
		"waybar"
		"media"
		"fish"
		"kitty"
		"appimage"
		"throne"
		"skwd-wall"
	];
}
