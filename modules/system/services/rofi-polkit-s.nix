{ config, pkgs, ... }:

{
  systemd.user.services.rofi-polkit-agent = {
    description = "Rofi Polkit Agent";
    after = [ "graphical-session.target" ];
    wantedBy = [ "default.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.cutom.rofi-polkit}/bin/rofi-polkit-agent";
      Restart = "on-failure";
    };
  };
}
