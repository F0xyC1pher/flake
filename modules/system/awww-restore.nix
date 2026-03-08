{
	inputs,
	config,
	vars,
	pkgs,
	...
}:
{
	systemd.user.services.awww-restore = {
		description = "awww cached wallpaper restore";

		requires = [ "awww-daemon.service" ];
		after = [ "awww-daemon.service" ];
		partOf = [ "graphical-session.target" ];
		wantedBy = [ "graphical-session.target" ];

		serviceConfig = {
			ExecStart = "${inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww}/bin/awww restore";
			Type = "oneshot";
		};
	};
}
