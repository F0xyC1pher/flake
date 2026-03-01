{
	inputs,
	config,
	vars,
	pkgs,
	...
}:
{
systemd.user.services.awww-daemon = {
    description = "awww wallpaper daemon";

    after = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];

    serviceConfig = {
      ExecStart = "inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww/bin/awww-daemon";
      Restart = "on-failure";
      RestartSec = 1;
    };
  };
}
