{ pkgs, config, lib, ... }:

let
	rofiPolkit = import ../packages/rofi-polkit.nix { inherit pkgs; };
in
{
	systemd.user.services.rofi-polkit-agent = {
		description = "Rofi-based Polkit Authentication Agent";

		wantedBy = [ "niri.service" ];
		after = [ "niri.service" ];

		serviceConfig = {
			Type = "simple";
			ExecStart = "${rofiPolkit}/bin/rofi-polkit-agent";
			Restart = "on-failure";
			RestartSec = 3;
		};
	};
}
