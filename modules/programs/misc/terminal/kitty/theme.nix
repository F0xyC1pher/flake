# ── Kitty colors — role-driven ────────────────────────────────────────────────
{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {vars, ...}: {
			programs.kitty.settings = let
				t = vars.theme.style;
				c.a = {
					n = vars.theme.colors.accent.bg.normal;
					b = vars.theme.colors.accent.bg.bright;
				};
				c.b = vars.theme.colors.base;
			in {
				# ── UI chrome ──────────────────────────────────────────────────────────
				background = t.ui.bg;
				foreground = t.text.main;
				selection_background = t.text.dimmed;
				selection_foreground = t.text.main;
				url_color = t.text.syntax.info;
				cursor = t.text.main;
				cursor_text_color = t.ui.bg;

				active_border_color = t.ui.border.active;
				inactive_border_color = t.ui.border.inactive;

				active_tab_background = t.accent;
				active_tab_foreground = t.ui.bg;
				inactive_tab_background = t.ui.overlay;
				inactive_tab_foreground = t.text.dimmed;
				tab_bar_background = t.ui.bg;

				wayland_titlebar_color = t.ui.bg;
				macos_titlebar_color = t.ui.bg;

				# ── Normal (0-7) ───────────────────────────────────────────────────────
				color0 = t.ui.bg;
				color1 = c.a.n.red;
				color2 = c.a.n.green;
				color3 = c.a.n.yellow;
				color4 = c.a.n.blue;
				color5 = c.a.n.magenta;
				color6 = c.a.n.cyan;
				color7 = t.text.main;

				# ── Bright (8-15) ──────────────────────────────────────────────────────
				color8 = t.ui.overlay;
				color9 = c.a.b.red;
				color10 = c.a.b.green;
				color11 = c.a.b.yellow;
				color12 = c.a.b.blue;
				color13 = c.a.b.magenta;
				color14 = c.a.b.cyan;
				color15 = t.text.heading;
			};
		};
	};
}
