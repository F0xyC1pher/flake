{
	inputs,
	config,
	vars,
	pkgs,
	...
}:
{
	systemd.user.services.waybar = {
		description = "Waybar: customizable bar for Wayland";
		wantedBy = [ "graphical-session.target" ];
		after = [ "niri.service" ];
		partOf = [ "niri.service" ];

		serviceConfig = {
			ExecStart = "/nix/store/0qmbn5xhlngn8y6yfykbpbdmpckng58g-waybar-0.15.0/bin/waybar";
			ExecReload = "/nix/store/hlxw2q9qansq7bn52xvlb5badw3z1v8s-coreutils-9.10/bin/kill -SIGUSR2 $MAINPID";
			KillMode = "mixed";
			Restart = "on-failure";
			RestartSec = 0.5;
		};
	};
}
