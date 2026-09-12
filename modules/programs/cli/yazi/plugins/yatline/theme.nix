{
	vars,
	lib,
	...
}: let
	style = vars.theme.style;
	colors = vars.theme.colors;
in {
	home-manager = {
		extraSpecialArgs = {inherit vars;};
		users.${vars.user.name} = {...}: {
			programs.yazi.plugins.yatline.settings.theme =
				lib.mkLuaInline ''
					{
					  section_separator = { open = "", close = "" },
					  part_separator = { open = "", close = "" },
					  inverse_separator = { open = "", close = "" },

					  style_a = {
					    fg = "${style.text.onAccent}",
					    bg_mode = {
					      normal = "${style.accent}",
					      select = "${colors.accent.bg.normal.yellow}",
					      un_set = "${colors.accent.bg.normal.orange}"
					    }
					  },
					  style_b = { bg = "${style.ui.surface}", fg = "${style.text.main}" },
					  style_c = { bg = "${style.ui.bg}", fg = "${style.text.dimmed}" },

					  permissions_t_fg = "${colors.accent.bg.normal.green}",
					  permissions_r_fg = "${colors.accent.bg.normal.yellow}",
					  permissions_w_fg = "${colors.accent.bg.normal.red}",
					  permissions_x_fg = "${colors.accent.bg.normal.cyan}",
					  permissions_s_fg = "${style.text.heading}",

					  selected = { icon = "󰻭", fg = "${colors.accent.bg.normal.yellow}" },
					  copied   = { icon = "", fg = "${colors.accent.bg.normal.green}" },
					  cut      = { icon = "", fg = "${colors.accent.bg.normal.red}" },
					  files    = { icon = "", fg = "${colors.accent.bg.normal.blue}" },
					  filtereds = { icon = "", fg = "${colors.accent.bg.normal.magenta}" },

					  total   = { icon = "󰮍", fg = "${colors.accent.bg.normal.yellow}" },
					  success = { icon = "", fg = "${colors.accent.bg.normal.green}" },
					  failed  = { icon = "", fg = "${colors.accent.bg.normal.red}" }
					}
				'';
		};
	};
}
