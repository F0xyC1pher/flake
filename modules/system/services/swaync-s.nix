{
	inputs,
	config,
	vars,
	pkgs,
	...
}:
let
	swaync = pkgs.swaync;
in
{
	systemd.user.services.swaync = {
		description = "swaync notification daemon";
		wantedBy = [ "graphical-session.target" ];
		after = [ "niri.service" ];
		partOf = [ "niri.service" ];

		serviceConfig = {
			ExecStart = "${swaync}/bin/swaync";
			Restart = "on-failure";
			RestartSec = 1;
		};
	};
}
