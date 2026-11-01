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
  hjem.users.${vars.user.name}.xdg.config.files = {
    "hypr/03-general.lua".text = /* lua */''
      hl.config({
        general = {
          gaps_in = ${toString vars.theme.gaps."in"},
          gaps_out = ${toString vars.theme.gaps."out"},
          border_size = ${toString vars.theme.border.size},
          layout = "scrolling",
      		locale = "ru_RU",
      		allow_tearing = true,
          col = {
            active_border = "${activeBorder}",
            inactive_border = "${inactiveBorder}",
          },
        },
      	binds = {
      		focus_preferred_method = 1,
      	},
      	scrolling = {
      		fullscreen_on_one_column = false,
      		follow_focus = true,
					 column_width = 0.75,
      		focus_fit_method = 1,
      		explicit_column_widths = "0.5, 0.75, 1.0",
      		direction = "right",
      		follow_min_visible = 0.0,
      	},
      	opengl = {
      		nvidia_anti_flicker = false,
      	},
      	render = {
      		async_commit = true,
      		direct_scanout = 1,
      	},
      	ecosystem = {
      		no_donation_nag = true,
      		no_update_news = true,
      	},
      })
    '';
  };
}
