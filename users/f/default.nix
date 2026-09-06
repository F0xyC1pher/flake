{...}: {
	theme = {
		name = "theMe";
		# accentLevel = "normal"; # "dimmed" | "normal" | "bright"
		# accentColor = "red"; # "red" | "orange" | "yellow" | "green" | "cyan" | "blue" | "purple" | "magenta"

		# gaps = 8;
		opacity = 0.666;
		liquid-glass.enable = true;
		blur = {
			enable = true;
			xray.enable = false;
		};
		border = {
			width = 2;
			radius = 0;
		};
		font = {
			name = "CaskaydiaCove Nerd Font Mono";
			size = 12;
		};
	};
	app = {
		terminal = "kitty";
		launcher = "fuzzel";
		file-manager = {
			tui = "yazi";
			gui = null;
		};
		browser = {
			gui = "firefox";
			tui = "lyx";
		};
		text-editor = {
			gui = "zeditor";
			tui = "micro";
		};
	};
	user = {
		fullName = "F0xy_C1pher";
		mail = "ageev-eldar@mail.ru";
		gitName = "F0xy_C1pher";
		password = "$6$AntMCBLfJ4foukEM$UrkX24HXtg4oUToaOv6YNzoTigCoYX9CbbyY0pNRk6ZmVG/3StBux6gDWA1dWSIE490PF4Q/YFcVixA7gc8zy.";
		shell = "fish"; # fish zsh bash brush
	};
	system = {
		modKey = "Super"; # Super Mod4
		desktopShell = "custom"; # custom dms noctalia
	};
	programs = [
		"firefox"
		"yazi"
		"git"
		"micro"
		"nh"
		"niri"
		"hyprland"
		"no-gnome"
		"xwayland"
		"dev"
		"gayming"
		"cursor" # вообще он должен быть всегда импортирован если есть окружение, типа он всегда нужен если ты не в tty
		"fonts"
		"fuzzel"
		"gtk"
		"qt"
		"waybar"
		"media"
		"fish"
		"kitty"
		"appimage"
		"fastfetch"
		"throne"
		"swaylock"
		"dconf"
		"nixvim"
		# "skwd-wall"
	];
	services = [
		"display-manager"
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
