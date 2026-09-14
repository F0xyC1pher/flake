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
						    gaps_in = 20,
						    gaps_out = 20,
						    border_size = ${toString vars.theme.border.size},
						    layout = "scrolling",
						    col = {
						      active_border = "${activeBorder}",
						      inactive_border = "${inactiveBorder}",
						    },
						  },
						})
					'';
				};
			};
		};
	};
}
