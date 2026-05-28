{
  inputs,
  vars,
  ...
}:
{
  home-manager = {
    extraSpecialArgs = { inherit inputs vars; };
    users.${vars.user.name} =
      { ... }:
      {
        services.playerctld.enable = true;
      };
  };
}
