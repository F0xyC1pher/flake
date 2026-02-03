{
    config,
    pkgs,
    lib,
    ...
}: {
    xdg = {
    	mime.enable = true;
    	mime.defaultApplications = { "inode/directory" = "yazi.desktop"; };
    	terminal-exec = {
    		enable = true;
    		settings = {
    			default = [
    				"kitty.desktop"
    			];
    		};
    	};
		portal = {
			enable = true;
			xdgOpenUsePortal = true;
			extraPortals = lib.mkForce [
				pkgs.xdg-desktop-portal-termfilechooser
				pkgs.xdg-desktop-portal-wlr
				pkgs.xdg-desktop-portal-gtk
			];
			# config = {
			# 	common = lib.mkForce {
			# 		"org.freedesktop.portal.Inhibit" = "none";
			# 		"org.freedesktop.impl.portal.Settings" = "luminous";
			# 		"org.freedesktop.impl.portal.FileChooser" = ["termfilechooser"];
			# 		"org.freedesktop.impl.portal.ScreenCast" = "luminous";
			# 		"org.freedesktop.impl.portal.Screenshot" = "luminous";
			# 		default = ["termfilechooser" "luminous"];	
			# };
			# 	niri = lib.mkForce {
			# 		"org.freedesktop.portal.Inhibit" = "none";
			# 		"org.freedesktop.impl.portal.FileChooser" = ["termfilechooser"];
			# 		"org.freedesktop.impl.portal.Settings" = "luminous";
			# 		"org.freedesktop.impl.portal.ScreenCast" = "luminous";
			# 		"org.freedesktop.impl.portal.Screenshot" = "luminous";
			# 		default = ["termfilechooser" "luminous"];	
			# 	};
			# };			
			# configPackages = lib.mkForce [
			# 	pkgs.xdg-desktop-portal-termfilechooser
			# 	pkgs.xdg-desktop-portal-luminous
			# ];
		};
    };
    
	environment.etc."xdg/xdg-desktop-portal-termfilechooser/config".text = ''
[filechooser]
cmd = /etc/xdg/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
  '';
	environment.etc."xdg/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh" = {
		mode = "0755";
		text = ''
#!${pkgs.bash}/bin/bash
set -eu

TERMCMD="${pkgs.kitty}/bin/kitty"
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
