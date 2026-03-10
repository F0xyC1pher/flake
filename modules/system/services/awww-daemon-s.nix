{
  inputs,
  pkgs,
  ...
}:
let
  awww = inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww;
in
{
  systemd.user.services.awww-daemon = {
    description = "awww daemon";

    wantedBy = [ "niri.service" ];
    after = [ "niri.service" ];
    partOf = [ "niri.service" ];

    serviceConfig = {
      ExecStartPre = "${pkgs.coreutils}/bin/rm -f /run/user/%U/*-awww-daemon.sock";
      ExecStart = "${awww}/bin/awww-daemon";

      Restart = "on-failure";
      RestartSec = 1;
    };
  };
}
