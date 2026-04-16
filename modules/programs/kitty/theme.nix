{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			programs.kitty = {
				settings = {
					# vim:ft=kitty

					## name:     base16 untitled
					## author:   FoxyChipher
					## license:  MIT
					## upstream: https://github.com/tinted-theming/tinted-kitty
					## blurb:    untitled

					# Scheme name: base16 untitled
					# Scheme author: FoxyChipher
					# Template author: Tinted Theming (https://github.com/tinted-theming/tinted-kitty)

					background = "#161616";
					foreground = "#d6d6d6";
					selection_background = "#969696";
					selection_foreground = "#d6d6d6";
					url_color = "#a6a6a6";
					cursor = "#d6d6d6";
					cursor_text_color = "#161616";
					active_border_color = "#969696";
					inactive_border_color = "#262626";
					active_tab_background = "#161616";
					active_tab_foreground = "#d6d6d6";
					inactive_tab_background = "#262626";
					inactive_tab_foreground = "#a6a6a6";
					tab_bar_background = "#262626";
					wayland_titlebar_color = "#161616";
					macos_titlebar_color = "#161616";

					# normal
					color0 = "#161616";
					color1 = "#f67676";
					color2 = "#76f676";
					color3 = "#f6f676";
					color4 = "#76a6f6";
					color5 = "#b676f6";
					color6 = "#76f6f6";
					color7 = "#d6d6d6";

					# bright
					color8 = "#464646";
					color9 = "#f67676";
					color10 = "#76f676";
					color11 = "#f6f676";
					color12 = "#76a6f6";
					color13 = "#b676f6";
					color14 = "#76f6f6";
					color15 = "#f6f6f6";

					# extended base16 colors
					color16 = "#f6b676";
					color17 = "#f676b6";
					color18 = "#262626";
					color19 = "#464646";
					color20 = "#a6a6a6";
					color21 = "#e6e6e6";
				};
			};
		};
	};
}
