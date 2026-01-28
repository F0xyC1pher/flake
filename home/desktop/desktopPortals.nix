{
    config,
    pkgs,
    ...
}: {
    xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [
            xdg-desktop-portal-termfilechooser
            xdg-desktop-portal-gtk
        ];

        config = {
            common.default = ["gtk" "termfilechooser"];
            common."org.freedesktop.impl.portal.FileChooser" = ["termfileschooser"];

            hyprland.default = ["gtk" "termfilechooser"];
        };
    };

    xdg.configFile."xdg-desktop-portal-termfilechooser/config".text = ''
        [filechooser]
        cmd = ${config.home.homeDirectory}/.config/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
    '';

    xdg.configFile."xdg-desktop-portal-termfilechooser/yazi-wrapper.sh" = {
        executable = true;
        text = ''
            #!${pkgs.bash}/bin/bash
            set -eu

            TERMCMD="${config.terminal}"
            multiple="$1"
            directory="$2"
            save="$3"
            path="$4"
            out="$5"

            cmd="${pkgs.yazi}/bin/yazi"

            if [ "$save" = "1" ]; then
                exec "$TERMCMD" "$cmd" --chooser-file="$out" "$path"
            elif [ "$directory" = "1" ]; then
                exec "$TERMCMD" "$cmd" --cwd-file="$out" "$path"
            else
                if [ "$multiple" = "1" ]; then
                    exec "$TERMCMD" "$cmd" --chooser-file="$out" --choose-multiple "$path"
                else
                    exec "$TERMCMD" "$cmd" --chooser-file="$out" "$path"
                fi
            fi
        '';
    };
}