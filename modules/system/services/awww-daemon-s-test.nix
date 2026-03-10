# flake.nix (или внутри modules/system/services/awww.nix)
{ config, pkgs, lib, inputs, vars, ... }:

let
	awww = inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww;
in
{
  # === Демон awww ===
  systemd.user.services.awww-daemon = {
    description = "awww wallpaper daemon";
    wantedBy = [ "graphical-session.target" ];
    after = [ "niri.service" ];
    partOf = [ "niri.service" ];

    serviceConfig = {
      # очищаем старые сокеты перед запуском
      ExecStartPre = "${pkgs.coreutils}/bin/rm -f /run/user/%U/*-awww-daemon.sock";
      ExecStart = "${awww}/bin/awww-daemon";
      Restart = "on-failure";
      RestartSec = 1;
    };
  };

  # === Path юнит для восстановления wallpaper ===
  systemd.user.paths.awww-restore = {
    name = "awww-restore.path";
    wantedBy = [ "graphical-session.target" ];

    # отслеживаем появление сокета демона
    pathConfig = {
      PathExistsGlob = "/run/user/%U/wayland-*-awww-daemon.sock";
    };

    # запускаем сервис restore
    requires = [ "awww-restore.service" ];
    after = [ "awww-daemon.service" ];
  };

  # === Сервис restore ===
  systemd.user.services.awww-restore = {
    description = "awww restore wallpaper";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${awww}/bin/awww restore";
    };
  };
}
