{pkgs, ...}: let
	awww = pkgs.awww;
in {
	systemd.user.services.awww-restore = {
		description = "Restore wallpaper";

		serviceConfig = {
			Type = "oneshot";
			ExecStart = "${awww}/bin/awww restore";
		};
	};
}
