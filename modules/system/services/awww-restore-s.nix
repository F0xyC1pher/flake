{
  inputs,
  pkgs,
  ...
}:
let
  awww = inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww;
in
{
  systemd.user.services.awww-restore = {
    description = "Restore wallpaper";

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${awww}/bin/awww restore";
    };
  };
}
