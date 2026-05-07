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
				c = vars.theme.colors.accent;
			in {
				# ── UI chrome ──────────────────────────────────────────────────────────
				background = t.ui."0";
				foreground = t.text.main;
				selection_background = t.text.sub-main;
				selection_foreground = t.text.main;
				url_color = t.text.syntax.info;
				cursor = t.text.main;
				cursor_text_color = t.ui."0";

				active_border_color = t.accent;
				inactive_border_color = t.text.sub-main;

				active_tab_background = t.accent;
				active_tab_foreground = t.ui."0";
				inactive_tab_background = t.ui."2";
				inactive_tab_foreground = t.text.sub-main;
				tab_bar_background = t.ui."0";

				wayland_titlebar_color = t.ui."0";
				macos_titlebar_color = t.ui."0";

				# ── Normal (0-7) ───────────────────────────────────────────────────────
				color0 = t.ui."0";
				color1 = c.red;
				color2 = c.green;
				color3 = c.yellow;
				color4 = c.blue;
				color5 = c.purple;
				color6 = c.cyan;
				color7 = t.text.main;

				# ── Bright (8-15) ──────────────────────────────────────────────────────
				color8 = t.ui."4";
				color9 = c.red;
				color10 = c.green;
				color11 = c.yellow;
				color12 = c.blue;
				color13 = c.purple;
				color14 = c.cyan;
				color15 = t.text.heading;

				# ── Extended base16 (16-21) ────────────────────────────────────────────
				color16 = c.orange;
				color17 = c.pink;
				color18 = t.ui."2";
				color19 = t.ui."4";
				color20 = t.text.faint;
				color21 = t.text.highlight;
			};
		};
	};
}
