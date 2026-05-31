{
  inputs,
  vars,
  ...
}:
{
  imports = [
    ./extensions.nix
    ./policies.nix
    ./userChrome.nix
    ./userContent.nix
    ./userJS.nix
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs vars; };
    users.${vars.user.name} =
      { ... }:
      {
        programs.firefox = {
          enable = true;
          profiles.${vars.user.fullName} = {
            name = "${vars.user.fullName}";
            isDefault = true;
            id = 0;
          };
        };
      };
  };
}
