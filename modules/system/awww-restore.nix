{
	inputs,
	config,
	vars,
	pkgs,
	...
}:
{
systemd.user.services.awww-restore = {
    description = "awww wallpaper restore";

    after = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];

    serviceConfig = {
      ExecStart = "${inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww}/bin/awww restore";
      Restart = "on-failure";
      RestartSec = 1;
    };
  };
}
