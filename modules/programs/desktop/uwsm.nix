{
  # pkgs,
  # lib,
  # inputs,
  # vars,
  ...
}: {
  programs = {
    uwsm = {
      enable = true;
      # waylandCompositors = {
      #   "niri" = lib.mkIf (vars.hasProgram "niri") {
      #     prettyName = "Niri";
      #     binPath = "${lib.getExe inputs.biri.packages.${pkgs.stdenv.hostPlatform.system}.default}";
      #     extraArgs = [
      #       "--session"
      #     ];
      #   };
      #   "hyprland" = lib.mkIf (vars.hasProgram "hyprland") {
      #     prettyName = "Hyprland";
      #     binPath = ''${lib.getExe' inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland "start-hyprland"}'';
      #   };
      #   scroll = lib.mkIf (vars.hasProgram "scroll") {
      #     prettyName = "Scroll";
      #     comment = "Scroll compositor managed by UWSM";
      #     binPath = "/run/current-system/sw/bin/scroll";
      #   };
      # };
    };
  };
}
