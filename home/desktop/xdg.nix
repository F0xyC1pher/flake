{
    config,
    pkgs,
    lib,
    ...
}: {
    xdg = {
		portal = {
			enable = true;
			xdgOpenUsePortal = true;
			extraPortals = lib.mkForce [
				pkgs.xdg-desktop-portal-termfilechooser
				pkgs.xdg-desktop-portal-luminous
			];
			config = {
				common = lib.mkForce {
					"org.freedesktop.impl.portal.FileChooser" = ["termfilechooser"];
					"org.freedesktop.impl.portal.ScreenCast" = "luminous";
					"org.freedesktop.impl.portal.Screenshot" = "luminous";
					default = ["termfilechooser" "luminous"];	
			};
				niri = lib.mkForce {
					"org.freedesktop.impl.portal.FileChooser" = ["termfilechooser"];
					"org.freedesktop.impl.portal.ScreenCast" = "luminous";
					"org.freedesktop.impl.portal.Screenshot" = "luminous";
					default = ["termfilechooser" "luminous"];	
				};
			};			
			configPackages = lib.mkForce [
				pkgs.xdg-desktop-portal-termfilechooser
				pkgs.xdg-desktop-portal-luminous
			];
		};

	    configFile."xdg-desktop-portal-termfilechooser/config" = {
			enable = true;
			force = true;
		    text = ''
	        [filechooser]
	        cmd = ${config.home.homeDirectory}/.config/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
	        default_dir=${config.home.homeDirectory}/Downloads
	        env=TERMCMD=kitty
	        open_mode=suggested
	        save_mode=last
		    '';
		};
	    configFile."xdg-desktop-portal-termfilechooser/yazi-wrapper.sh" = {
			enable = true;
	        executable = true;
	        force = true;
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
    };
}
