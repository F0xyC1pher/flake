{
  lib,
  inputs,
  vars,
  ...
}: {
  home-manager.users.${vars.user.name} = {pkgs, ...}: {
    xdg.configFile."xdg-desktop-portal/portals.conf".force = true;
    xdg.portal = lib.mkForce {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals =
        [
          pkgs.xdg-desktop-portal-termfilechooser
          pkgs.xdg-desktop-portal-gtk
        ]
        ++ lib.optional (vars.hasProgram "umbriel") inputs.xdg-desktop-portal-umbriel.packages.${pkgs.stdenv.hostPlatform.system}.default
        ++ lib.optional (vars.hasProgram "niri") inputs.niri-screenshare.packages.${pkgs.stdenv.hostPlatform.system}.default
        ++ lib.optional (vars.hasProgram "hyprland") inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      config = {
        common = {
          default = ["termfilechooser" "gtk"];
          "org.freedesktop.impl.portal.FileChooser" = ["termfilechooser"];
          "org.freedesktop.impl.portal.Settings" = ["gtk"];
        };
        niri = lib.mkIf (vars.hasProgram "niri") {
          default = ["termfilechooser" "niri" "gtk"];
          "org.freedesktop.impl.portal.FileChooser" = ["termfilechooser"];
          "org.freedesktop.impl.portal.ScreenCast" = ["niri"];
          "org.freedesktop.impl.portal.Settings" = ["gtk"];
        };
        Hyprland = lib.mkIf (vars.hasProgram "hyprland") {
          default = ["termfilechooser" "hyprland" "gtk"];
          "org.freedesktop.impl.portal.FileChooser" = ["termfilechooser"];
          "org.freedesktop.impl.portal.ScreenCast" = ["hyprland"];
          "org.freedesktop.impl.portal.Settings" = ["gtk"];
        };
        umbriel = lib.mkIf (vars.hasProgram "umbriel") {
          default = ["termfilechooser" "umbriel" "gtk"];
          "org.freedesktop.impl.portal.FileChooser" = ["termfilechooser"];
          "org.freedesktop.impl.portal.ScreenCast" = ["umbriel"];
          "org.freedesktop.impl.portal.Settings" = ["gtk"];
        };
        scroll = lib.mkIf (vars.hasProgram "scroll") {
          default = ["termfilechooser" "wlr" "gtk"];
          "org.freedesktop.impl.portal.FileChooser" = ["termfilechooser"];
          "org.freedesktop.impl.portal.ScreenCast" = ["wlr"];
          "org.freedesktop.impl.portal.Screenshot" = ["wlr"];
          "org.freedesktop.impl.portal.Inhibit" = "none";
          "org.freedesktop.impl.portal.Settings" = ["gtk"];
        };
      };
    };
  };
}
