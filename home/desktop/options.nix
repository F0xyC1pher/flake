{ config, pkgs, lib, ... }: {
    options = {
        terminal = lib.mkOption {
            type = lib.types.str;
            default = "${pkgs.kitty}/bin/kitty";
            description = "Default terminal emulator.";
        };
        # wallpapersDir = lib.mkOption {
        #     type = lib.types.str;
        #     default = "${config.home.homeDirectory}/Pictures/wallpapers";
        #     description = "The directory to llook for wallpapers.";
        # };
    };
}
