{
  inputs,
  pkgs,
  vars,
  ...
}: {
  imports = [
    ./config
  ];
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    withUWSM = vars.hasProgram "uwsm";
  };
  # hjem.users.${vars.user.name}.rum.desktops.hyprland.enable = true;
}
