{
	pkgs,
	lib,
	vars,
	...
}: {
	xdg = {
		portal = {
			enable = true;
			xdgOpenUsePortal = true;
			extraPortals =
				lib.mkForce [
					pkgs.xdg-desktop-portal-termfilechooser
					pkgs.xdg-desktop-portal-wlr
					pkgs.xdg-desktop-portal-gtk
				];
			wlr = {
				enable = true;
				# settings.screencast = {
				# 	chooser_type = "simple";
				# 	chooser_cmd = "${pkgs.slurp}/bin/slurp -f 'Monitor: %o' -or";
				# };
			};
			config = {
				common =
					lib.mkForce {
						"org.freedesktop.impl.portal.FileChooser" = ["termfilechooser"];
						"org.freedesktop.impl.portal.ScreenCast" = ["wlr"];
						"org.freedesktop.impl.portal.Screenshot" = ["wlr"];
						"org.freedesktop.impl.portal.Settings" = ["gtk"];
						default = ["termfilechooser" "wlr" "gtk"];
					};
			};
		};
	};

	environment.etc = {
		"xdg/xdg-desktop-portal-termfilechooser/config" = {
			text = ''
				[filechooser]
				cmd = /etc/xdg/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
			'';
		};

		"xdg/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh" = {
			mode = "0755";
			text = ''
				#!${pkgs.bash}/bin/bash
				set -eu

				TERMCMD="${pkgs.${vars.app.terminal}}/bin/${vars.app.terminal} -e"
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

	home-manager.users.${vars.user.name} = {
		pkgs,
		lib,
		...
	}: {
		xdg = {
			portal = {
				enable = true;
				xdgOpenUsePortal = true;
				extraPortals =
					lib.mkForce [
						pkgs.xdg-desktop-portal-termfilechooser
						pkgs.xdg-desktop-portal-wlr
						pkgs.xdg-desktop-portal-gtk
					];
				config = {
					common =
						lib.mkForce {
							"org.freedesktop.impl.portal.FileChooser" = ["termfilechooser"];
							"org.freedesktop.impl.portal.ScreenCast" = ["wlr"];
							"org.freedesktop.impl.portal.Screenshot" = ["wlr"];
							"org.freedesktop.impl.portal.Settings" = ["gtk"];
							default = ["termfilechooser" "wlr" "gtk"];
						};
				};
			};
		};
	};
}
