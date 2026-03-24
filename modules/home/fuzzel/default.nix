{
  lib,
  config,
  pkgs,
  inputs,
  vars,
  ...
}:
{
  home-manager = {
    extraSpecialArgs = { inherit inputs vars; };
    users.${vars.userName} =
      {
        config,
        pkgs,
        lib,
        ...
      }:
      {
        programs.fuzzel = {
          enable = true;
          settings = {

          };
        };
      };
  };
}
