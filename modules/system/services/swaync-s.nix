{
	inputs,
	config,
	vars,
	pkgs,
	...
}:
let
	swaync = pkgs.swaynotificationcenter;
in
{
	systemd.user.services.swaync = {
		description = "swaync notification daemon";
		wantedBy = [ "niri.service" ];
		after = [ "niri.service" ];
		partOf = [ "niri.service" ];

		serviceConfig = {
			ExecStart = "${swaync}/bin/swaync";
			Restart = "on-failure";
			RestartSec = 1;
		};
	};
}
