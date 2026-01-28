{
    config,
    pkgs,
    inputs,
    ...
}: {
    imports = [
        # ./general
        ./desktop
        ./home.nix
        # ./development
        # ./gaming
    ];

    # home.username = "f";
    # home.stateVersion = "25.05";
}
