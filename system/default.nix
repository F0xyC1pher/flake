{
    config,
    pkgs,
    inputs,
    ...
}: {
    imports = [
        ./configuration.nix
        ./hardware.nix
        ./xdg.nix
		./apps.nix
        # ./development
        # ./gaming
    ];

    # home.username = "f";
    # home.stateVersion = "25.05";
}
