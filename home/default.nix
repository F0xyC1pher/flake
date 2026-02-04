{
    config,
    pkgs,
    inputs,
    vars,
    ...
}: {
    imports = [
        # ./general
        ./desktop
        ./home.nix
        # ./development
        # ./gaming
    ];

    home.username = "${vars.userName}";
    home.homeDirectory = "/home/${vars.userName}";
    home.stateVersion = "25.05";
}
