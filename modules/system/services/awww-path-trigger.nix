{
systemd.user.paths.awww-restore = {
  name = "awww-restore.path";
  wantedBy = [ "graphical-session.target" ];
  pathConfig = {
    PathExistsGlob = "/run/user/%U/wayland-*-awww-daemon.sock";
  };
  requires = [ "awww-restore.service" ];  # запускает сервис
  after = [ "awww-daemon.service" ];       # ждет демон
};
}
