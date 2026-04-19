{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {vars, ...}: {
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

					background = vars.style.theme.ui."0";
					foreground = vars.style.theme.text.main;
					selection_background = vars.style.theme.text.sub-main;
					selection_foreground = vars.style.theme.text.main;
					url_color = vars.style.theme.text.syntax.info;
					cursor = vars.style.theme.text.main;
					cursor_text_color = vars.style.theme.ui."0";
					active_border_color = vars.style.theme.accent;
					inactive_border_color = vars.style.theme.text.sub-main;
					active_tab_background = vars.style.theme.accent;
					active_tab_foreground = vars.style.theme.ui."0";
					inactive_tab_background = vars.style.theme.ui."2";
					inactive_tab_foreground = vars.style.theme.text.sub-main;
					tab_bar_background = vars.style.theme.ui."0";
					wayland_titlebar_color = vars.style.theme.ui."0";
					macos_titlebar_color = vars.style.theme.ui."0";

					# normal
					color0 = vars.style.theme.ui."0";
					color1 = vars.style.colors.accent.red;
					color2 = vars.style.colors.accent.green;
					color3 = vars.style.colors.accent.yellow;
					color4 = vars.style.colors.accent.blue;
					color5 = vars.style.colors.accent.purple;
					color6 = vars.style.colors.accent.cyan;
					color7 = vars.style.theme.text.main;

					# bright
					color8 = vars.style.theme.ui."4";
					color9 = vars.style.colors.accent.red;
					color10 = vars.style.colors.accent.green;
					color11 = vars.style.colors.accent.yellow;
					color12 = vars.style.colors.accent.blue;
					color13 = vars.style.colors.accent.purple;
					color14 = vars.style.colors.accent.cyan;
					color15 = vars.style.theme.text.heading;

					# extended base16 colors
					color16 = vars.style.colors.accent.orange;
					color17 = vars.style.colors.accent.pink;
					color18 = vars.style.theme.ui."2";
					color19 = vars.style.theme.ui."4";
					color20 = vars.style.theme.text.faint;
					color21 = vars.style.theme.text.highlight;
				};
			};
		};
	};
}
