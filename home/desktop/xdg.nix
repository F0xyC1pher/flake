{
    config,
    pkgs,
    lib,
    ...
}: {
    xdg = {
		portal = {
			# enable = true;
			# xdgOpenUsePortal = true;
			# extraPortals = lib.mkForce [
				# pkgs.xdg-desktop-portal-termfilechooser
				# pkgs.xdg-desktop-portal-wlr
				# pkgs.xdg-desktop-portal-gtk
			# ];
			config = {
				common = lib.mkForce {
					"org.freedesktop.impl.portal.FileChooser" = ["termfilechooser"];
					"org.freedesktop.impl.portal.ScreenCast" = "wlr";
					"org.freedesktop.impl.portal.Screenshot" = "wlr";
					"org.freedesktop.impl.portal.Settings" = "gtk";
					default = ["termfilechooser" "wlr" "gtk"];	
				};
				# niri = lib.mkForce {
				# 	"org.freedesktop.impl.portal.FileChooser" = ["termfilechooser"];
				# 	"org.freedesktop.impl.portal.ScreenCast" = "luminous";
				# 	"org.freedesktop.impl.portal.Screenshot" = "luminous";
				# 	"org.freedesktop.impl.portal.Settings" = "luminous";
				# 	"org.freedesktop.portal.Inhibit" = "none";
				# 	default = ["luminous"];	
				# };
			};			
			# configPackages = lib.mkForce [
			# 	pkgs.xdg-desktop-portal-termfilechooser
			# 	pkgs.xdg-desktop-portal-wlr
			# ];
		};
# configFile."${config.home.homeDirectory}/.config/xdg-desktop-portal-luminous/config.toml" = {
# 	enable = true;
# 	force = true;
# 	text = ''
# color_scheme = "dark"
# accent_color = "#d76667"
# 	'';
# };
# 	    configFile."xdg-desktop-portal-termfilechooser/config" = {
# 			enable = true;
# 			force = true;
# 		    text = ''
# [filechooser]
# cmd = ${config.home.homeDirectory}/.config/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
# 		    '';
# create_help_file=1
# default_dir=${config.home.homeDirectory}/Downloads
# env=TERMCMD=kitty
# open_mode=suggested
# save_mode=last
		# };
# 	    configFile."xdg-desktop-portal-termfilechooser/yazi-wrapper.sh" = {
# 			enable = true;
# 	        executable = true;
# 	        force = true;
# 	        text = ''
# #!${pkgs.bash}/bin/bash
# set -e
# 
# TERMCMD="${config.terminal}"
# multiple="$1"
# directory="$2"
# save="$3"
# path="$4"
# out="$5"
# 
# cmd="${pkgs.yazi}/bin/yazi"
# 
# if [ "$save" = "1" ]; then
#     exec "$TERMCMD" "$cmd" --chooser-file="$out" "$path"
# elif [ "$directory" = "1" ]; then
#     exec "$TERMCMD" "$cmd" --cwd-file="$out" "$path"
# else
#     if [ "$multiple" = "1" ]; then
#         exec "$TERMCMD" "$cmd" --chooser-file="$out" --choose-multiple "$path"
#     else
#         exec "$TERMCMD" "$cmd" --chooser-file="$out" "$path"
#     fi
# fi
#         '';
# 		};
    };
}
