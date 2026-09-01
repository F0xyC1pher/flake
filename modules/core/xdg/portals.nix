{
	pkgs,
	lib,
	inputs,
	vars,
	...
}: {
	# xdg = {
	# 	portal = {
	# 		enable = true;
	# 		xdgOpenUsePortal = true;
	# 		extraPortals = [
	# 			pkgs.xdg-desktop-portal-termfilechooser
	# 			inputs.niri-screenshare.packages.${pkgs.stdenv.hostPlatform.system}.default
	# 			pkgs.xdg-desktop-portal-gtk
	# 		];
	# 		config = {
	# 			common = {
	# 				"org.freedesktop.impl.portal.FileChooser" = ["termfilechooser"];
	# 				"org.freedesktop.impl.portal.ScreenCast" = ["niri"];
	# 				"org.freedesktop.impl.portal.Settings" = ["gtk"];
	# 				default = ["termfilechooser" "niri" "gtk"];
	# 			};
	# 		};
	# 	};
	# };

	# environment.etc = {
	# 	"xdg/xdg-desktop-portal-termfilechooser/config" = {
	# 		text = ''
	# 			[filechooser]
	# 			cmd = /etc/xdg/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
	# 		'';
	# 	};

	# 	"xdg/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh" = {
	# 		mode = "0755";
	# 		text = ''
	# 			#!${pkgs.bash}/bin/bash
	# 			set -eu

	# 			TERMCMD="${pkgs.${vars.app.terminal}}/bin/${vars.app.terminal} -e"
	# 			multiple="$1"
	# 			directory="$2"
	# 			save="$3"
	# 			path="$4"
	# 			out="$5"

	# 			cmd="${pkgs.yazi}/bin/yazi"

	# 			if [ "$save" = "1" ]; then
	# 			    exec "$TERMCMD" "$cmd" --chooser-file="$out" "$path"
	# 			elif [ "$directory" = "1" ]; then
	# 			    exec "$TERMCMD" "$cmd" --cwd-file="$out" "$path"
	# 			else
	# 			    if [ "$multiple" = "1" ]; then
	# 			        exec "$TERMCMD" "$cmd" --chooser-file="$out" --choose-multiple "$path"
	# 			    else
	# 			        exec "$TERMCMD" "$cmd" --chooser-file="$out" "$path"
	# 			    fi
	# 			fi
	# 		'';
	# 	};
	# };

	home-manager.users.${vars.user.name} = {
		pkgs,
		lib,
		...
	}: {
		xdg = {
			portal = {
				enable = true;
				xdgOpenUsePortal = true;
				extraPortals = [
					pkgs.xdg-desktop-portal-termfilechooser
					inputs.niri-screenshare.packages.${pkgs.stdenv.hostPlatform.system}.default
					pkgs.xdg-desktop-portal-gtk
				];
				config = {
					common = {
						"org.freedesktop.impl.portal.FileChooser" = ["termfilechooser"];
						"org.freedesktop.impl.portal.ScreenCast" = ["niri"];
						"org.freedesktop.impl.portal.Settings" = ["gtk"];
						default = ["termfilechooser" "niri" "gtk"];
					};
				};
			};
		};
	};
}
