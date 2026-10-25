{
  lib,
  vars,
  ...
}: {
  imports =
    lib.flatten
    [
      ./alt-tab.nix
      ./animations.nix
      ./binds.nix
      (lib.optionals vars.theme.blur.enable [./blur.nix])
      ./colors.nix
      ./cursor.nix
      ./debug.nix
      ./input.nix
      ./layer-rules.nix
      ./layout.nix
      ./misc.nix
      ./outputs.nix
      ./window-rules.nix
    ];
  hjem.users.${vars.user.name} = let
    includes = lib.flatten [
      "alt-tab.kdl"
      "animations.kdl"
      (lib.optional vars.theme.blur.enable "blur.kdl")
      "binds.kdl"
      "colors.kdl"
      "cursor.kdl"
      "debug.kdl"
      "input.kdl"
      "layer-rules.kdl"
      "layout.kdl"
      "misc.kdl"
      "outputs.kdl"
      "window-rules.kdl"
    ];
  in {
    xdg.config.files."niri/config.kdl".text =
      lib.concatMapStringsSep "\n" (f: ''include "${f}"'') includes;
  };
}
