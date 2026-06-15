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
				color1 = c."0";
				color2 = c."c";
				color3 = c."6";
				color4 = c."l";
				color5 = c."r";
				color6 = c."i";
				color7 = t.text.main;

				# ── Bright (8-15) ──────────────────────────────────────────────────────
				color8 = t.ui."4";
				color9 = c."0";
				color10 = c."c";
				color11 = c."6";
				color12 = c."l";
				color13 = c."r";
				color14 = c."i";
				color15 = t.text.heading;

				# ── Extended base16 (16-21) ────────────────────────────────────────────
				color16 = c."3";
				color17 = c."x";
				color18 = t.ui."2";
				color19 = t.ui."4";
				color20 = t.text.faint;
				color21 = t.text.highlight;
			};
		};
	};
}
