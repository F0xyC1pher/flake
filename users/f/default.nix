{...}: {
	theme = {
		name = "theMe";
		# accentLevel = "normal"; # "dimmed" | "normal" | "bright"
		# accentColor = "red"; # "red" | "orange" | "yellow" | "green" | "cyan" | "blue" | "purple" | "magenta"

		# gaps = 8;
		border = {
			width = 2;
			radius = 0;
		};

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
			name = "CaskaydiaCove Nerd Font Mono";
			size = 14;
		};

		opacity = 0.666; # 0.4627

		blur = {
			enable = true;
			xray.enable = false;
		};

		liquid-glass.enable = true;
	};
	user = {
		fullName = "F0xy_C1pher";
		mail = "ageev-eldar@mail.ru";
		gitName = "F0xy_C1pher";
		password = "$6$AntMCBLfJ4foukEM$UrkX24HXtg4oUToaOv6YNzoTigCoYX9CbbyY0pNRk6ZmVG/3StBux6gDWA1dWSIE490PF4Q/YFcVixA7gc8zy.";
		shell = "fish"; # fish zsh bash brush
	};
	system = {
		modKey = "Mod4"; # Super
		desktopShell = "custom"; # custom dms noctalia
	};
	programs = [
		"firefox"
		"yazi"
		"git"
		"micro"
		"nh"
		"niri"
		# "hyprland"
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
		# "ghostty"
		# "wezterm"
		# "rio"
		"appimage"
		"fastfetch"
		"throne"
		"swaylock"
		# "skwd-wall"
	];
	services = [
		"displayManager"
		"polkit-service"
		"accounts-daemon"
		"arrpc"
		"awww"
		"cliphist"
		"cups"
		"dbus"
		"dropbox"
		"earlyloom"
		"flatpak"
		"gvfs"
		"locate"
		"mpd"
		"openssh"
		"pipewire"
		"playerctld"
		"resolved"
		"scx-loader"
		"seatd"
		"swayidle"
		"swaync"
		"tlp"
		"udev"
		"upower"
		"userborn"
		"wl-clip-persist"
		"xserver"
	];
}
