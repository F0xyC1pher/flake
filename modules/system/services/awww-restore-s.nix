{
	inputs,
	config,
	vars,
	pkgs,
	...
}:
let
	awww = inputs.awww.packages.${pkgs.system}.awww;
in
{
  systemd.user.services.awww-restore = {
    description = "awww wallpaper restore";
    wantedBy = [ "graphical-session.target" ];
    after = [ "awww-daemon.service" ];
    requires = [ "awww-daemon.service" ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${awww}/bin/awww restore";
    };
  };
}
