{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {vars,...}: {
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

					background = vars.style.theme.bgMain;
					foreground = vars.style.theme.fgMain;
					selection_background = vars.style.theme.subtext;
					selection_foreground = vars.style.theme.fgMain;
					url_color = vars.style.theme.statusline;
					cursor = vars.style.theme.fgMain;
					cursor_text_color = vars.style.theme.bgMain;
					active_border_color = vars.style.theme.accent;
					inactive_border_color = vars.style.theme.subtext;
					active_tab_background = vars.style.theme.accent;
					active_tab_foreground = vars.style.theme.bgMain;
					inactive_tab_background = vars.style.theme.surface2;
					inactive_tab_foreground = vars.style.theme.subtext;
					tab_bar_background = vars.style.theme.bgMain;
					wayland_titlebar_color = vars.style.theme.bgMain;
					macos_titlebar_color = vars.style.theme.bgMain;

					# normal
					color0 = vars.style.colors.b1;
					color1 = vars.style.colors.r0;
					color2 = vars.style.colors.g0;
					color3 = vars.style.colors.y0;
					color4 = vars.style.colors.b0;
					color5 = vars.style.colors.p0;
					color6 = vars.style.colors.c0;
					color7 = vars.style.colors.bd;

					# bright
					color8 = vars.style.colors.b4;
					color9 = vars.style.colors.r0;
					color10 = vars.style.colors.g0;
					color11 = vars.style.colors.y0;
					color12 = vars.style.colors.b0;
					color13 = vars.style.colors.p0;
					color14 = vars.style.colors.c0;
					color15 = vars.style.colors.bf;

					# extended base16 colors
					color16 = vars.style.colors.o0;
					color17 = vars.style.colors.p1;
					color18 = vars.style.colors.b2;
					color19 = vars.style.colors.b4;
					color20 = vars.style.colors.ba;
					color21 = vars.style.colors.be;
				};
			};
		};
	};
}
