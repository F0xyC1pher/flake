{pkgs, ...}: let
  awww = pkgs.awww;
in {
  systemd.user.services.awww-daemon = {
    description = "awww wallpaper daemon";
    wantedBy = ["graphical-session.target"];
    after = ["graphical-session-pre.target"];

    serviceConfig = {
      Type = "notify"; # ← ждём sd_notify от демона
      ExecStartPre = "${pkgs.coreutils}/bin/rm -f %t/*-awww-daemon.sock";
      ExecStart = "${awww}/bin/awww-daemon --layer background";
      ExecStartPost = "${awww}/bin/awww restore --all"; # ← без sleep, без цикла
      Restart = "always";
      RestartSec = 2;
    };
  };
}
