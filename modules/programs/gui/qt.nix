{vars, ...}: {
	home-manager.users.${vars.user.name} = {vars, ...}: let
		t = vars.theme.style;
	in {
		qt = {
			enable = true;
			platformTheme.name = "qt6ct";

			# Это форсирует QT_STYLE_OVERRIDE = "fusion" и подтянет нужные либы
			style.name = "fusion";

			qt6ctSettings = {
				Appearance = {
					custom_palette = true;
					standard_dialogs = "xdgdesktopportal";
					style = "fusion";
				};

				Fonts = {
					fixed = "\"${vars.theme.font.name},${toString vars.theme.font.size},-1,5,400,0,0,0,0,0,0,0,0,0,0,1\"";
					general = "\"${vars.theme.font.name},${toString vars.theme.font.size},-1,5,400,0,0,0,0,0,0,0,0,0,0,1\"";
				};

				ColorScheme = {
					active_colors = [
						"${t.text.main}"
						"${t.ui.surface}"
						"${t.ui.overlay}"
						"${t.ui.selection}"
						"${t.ui.border.inactive}"
						"${t.ui.highlight}"
						"${t.text.main}"
						"${t.text.heading}"
						"${t.ui.deep}"
						"${t.ui.main}"
						"${t.ui.deep}"
						"${t.accent}"
						"${t.text.main}"
						"${t.accent}"
						"${t.accent}"
						"${t.text.main}"
						"${t.ui.main}"
						"${t.text.main}"
						"${t.text.faint}"
						"${t.text.main}"
						"${t.ui.selection}"
					];

					inactive_colors = [
						"${t.text.faint}"
						"${t.ui.surface}"
						"${t.ui.overlay}"
						"${t.ui.selection}"
						"${t.ui.border.inactive}"
						"${t.ui.highlight}"
						"${t.text.faint}"
						"${t.text.faint}"
						"${t.ui.deep}"
						"${t.ui.main}"
						"${t.ui.deep}"
						"${t.ui.selection}"
						"${t.text.faint}"
						"${t.text.faint}"
						"${t.text.faint}"
						"${t.text.faint}"
						"${t.ui.main}"
						"${t.text.faint}"
						"${t.text.faint}"
						"${t.text.faint}"
						"${t.ui.selection}"
					];

					disabled_colors = [
						"${t.text.faint}"
						"${t.ui.surface}"
						"${t.ui.overlay}"
						"${t.ui.selection}"
						"${t.ui.border.inactive}"
						"${t.ui.highlight}"
						"${t.text.faint}"
						"${t.text.faint}"
						"${t.ui.deep}"
						"${t.ui.main}"
						"${t.ui.deep}"
						"${t.ui.selection}"
						"${t.text.faint}"
						"${t.text.faint}"
						"${t.text.faint}"
						"${t.text.faint}"
						"${t.ui.main}"
						"${t.text.faint}"
						"${t.text.faint}"
						"${t.text.faint}"
						"${t.ui.selection}"
					];
				};
			};
		};
	};
}
