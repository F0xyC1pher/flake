{
	vars,
	lib,
	...
}: let
	t = vars.theme.style;
	cleanHex = hex: lib.removePrefix "#" hex;
	activeBorder = "rgba(${cleanHex t.ui.border.active}ff)";
	inactiveBorder = "rgba(${cleanHex t.ui.border.inactive}${vars.theme.opacityHex})";
in {
	home-manager.users.${vars.user.name} = {
		wayland.windowManager.hyprland = {
			extraLuaFiles = {
				"03-general" = {
					autoLoad = true;
					content = ''
						hl.config({
						  general = {
						    gaps_in = ${toString vars.theme.gaps."in"},
						    gaps_out = ${toString vars.theme.gaps."out"},
						    border_size = ${toString vars.theme.border.size},
						    layout = "scrolling",
						    col = {
						      active_border = "${activeBorder}",
						      inactive_border = "${inactiveBorder}",
						    },
						  },
							scrolling = {
								fullscreen_on_one_column = false,
								follow_focus = true,
								column_width = 1.0,
								focus_fit_method = 1,
								explicit_column_widths = "0.5, 0.75, 1.0",
								direction = "down",
								follow_min_visible = 0.0,
							},
							opengl = {
								nvidia_anti_flicker = false,
							},
						})
					'';
				};
			};
		};
	};
}
