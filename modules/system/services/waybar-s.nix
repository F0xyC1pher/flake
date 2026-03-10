{
  inputs,
  config,
  vars,
  pkgs,
  ...
}:
{
  systemd.user.services.waybar = {
    description = "Waybar: customizable bar for Wayland";
    wantedBy = [ "graphical-session.target" ];
    after = [ "niri.service" ];
    partOf = [ "niri.service" ];

    serviceConfig = {
      Type = "simple"; # обязательно
      ExecStart = "${pkgs.waybar}/bin/waybar"; # путь из nixpkgs
      ExecReload = "/bin/kill -SIGUSR2 $MAINPID";
      KillMode = "mixed";
      Restart = "on-failure";
      RestartSec = 0.5;
    };
  };
}
