{
  # config,
  # lib,
  pkgs,
  inputs,
  vars,
  ...
}:
{
        imports = [
          ./animations.nix
          ./binds.nix
          ./colors.nix
          ./config.nix
          ./debug.nix
          ./input.nix
          ./layer-rules.nix
          ./layout.nix
          ./misc.nix
          ./outputs.nix
          ./window-rules.nix
        ];
}
