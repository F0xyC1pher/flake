{
inputs,
config,
vars,
pkgs,
...
}:
{
  let awww = inputs.awww.packages.${pkgs.system}.awww; in
  systemd.user.services.awww-daemon = {
    description = "awww daemon";
    wantedBy = [ "graphical-session.target" ];
    after = [ "niri.service" ];
    partOf = [ "niri.service" ];

    serviceConfig = {
      ExecStart = "${awww}/bin/awww-daemon";
      Restart = "on-failure";
      RestartSec = 1;
    };
  };
}
