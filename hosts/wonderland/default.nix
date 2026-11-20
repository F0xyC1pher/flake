{
  vars,
  ...
}: {
  imports = [
    # Replace the contents of this file with the output of
    # `sudo nixos-generate-config --show-hardware-config` on the new machine.
    ./place-hardware-configuration-here.nix
  ];

  # Replace XX.YY with the NixOS release you first installed this machine with.
  system.stateVersion = "XX.YY";

  home-manager = {
    extraSpecialArgs = {inherit vars;};
    users.${vars.user.name} = {...}: {
      # Use the same release as system.stateVersion.
      home.stateVersion = "XX.YY";
    };
  };
}
