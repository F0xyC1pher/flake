{
  inputs,
  vars,
  lib,
  pkgs,
  ...
}: {
  programs.niri = {
    enable = true;
    # package = inputs.niri-glass.packages.x86_64-linux.default;
    # package = pkgs.niri;
    package = inputs.biri.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };
  imports = [
    ./config
  ];
}
