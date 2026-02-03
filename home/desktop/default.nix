{
    config,
    pkgs,
    inputs,
    ...
}: {
    imports = [
        ./options.nix
        # ./xdg.nix
        # ./themes
        # ./hyprland
        # ./waybar
        # ./walker
        # ./rofi
    ];

    # home.file."${config.wallpapersDir}" = {
    #     source = ./wallpapers;
    # };
}
