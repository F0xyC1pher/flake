{
	inputs,
	vars,
	...
}: let
	style = vars.theme.style;
	themeData = {
		"$schema" = "https://zed.dev/schema/themes/v0.1.0.json";
		name = vars.theme.name;
		author = vars.user.fullName;
		themes = [
			{
				name = vars.theme.name;
				appearance =
					if vars.theme.dark
					then "dark"
					else "light";
				style = {
					/*
          Основной стиль окна и бордеры
          */
					"background.appearance" = "transparent";
					"background" = "${style.ui.bg}${vars.theme.opacityHex}";
					"border" = "${style.ui.border.inactive}${vars.theme.opacityHex}";
					"border.focused" = style.ui.border.active;
					"surface.background" = "${style.ui.bg}${vars.theme.opacityHex}";

					/*
          Шапка и тулбар
          */
					"title_bar.background" = "${style.ui.bg}${vars.theme.opacityHex}";
					"title_bar.inactive_background" = "${style.ui.bg}${vars.theme.opacityHex}";
					"toolbar.background" = "${style.ui.bg}00";

					/*
          Редактор кода
          */
					"editor.active_line.background" = "${style.ui.border.inactive}${vars.theme.opacityHex}";
					"editor.active_line_number" = style.text.heading;
					"editor.background" = "${style.ui.bg}00";
					"editor.gutter.background" = "${style.ui.bg}00";
					"editor.line_number" = style.text.comment;

					/*
          Панели и файлы
          */
					"drop_target.background" = "${style.ui.bg}00";
					"file_scan.background" = "${style.ui.bg}00";
					"panel.background" = "${style.ui.bg}00";
					"panel.focused_border" = style.ui.border.active;
					"project_panel.background" = "${style.ui.bg}00";

					/*
          Табы и статусбар
          */
					"status_bar.background" = "${style.ui.bg}${vars.theme.opacityHex}";
					"tab.active_background" = "${style.ui.surface}${vars.theme.opacityHex}";
					"tab.inactive_background" = "${style.ui.bg}00";
					"tab_bar.background" = "${style.ui.bg}00";

					/*
          Элементы UI и списки
          */
					"element.hover" = "${style.ui.surface}${vars.theme.opacityHex}";
					"element.selected" = "${style.ui.border.active}${vars.theme.opacityHex}";
					"ghost_element.background" = "${style.ui.bg}00";
					"ghost_element.hover" = "${style.ui.surface}${vars.theme.opacityHex}";
					"ghost_element.selected" = "${style.ui.border.active}${vars.theme.opacityHex}";
					"list.active_item" = "${style.ui.surface}${vars.theme.opacityHex}";
					"list.hover_item" = "${style.ui.surface}${vars.theme.opacityHex}";
					"list.inactive_item" = "${style.ui.bg}00";

					/*
          Текст
          */
					"text" = style.text.main;
					"text.accent" = style.ui.border.active;
					"text.muted" = style.text.dimmed;

					/*
          Подсветка синтаксиса
          */
					syntax = {
						comment = {
							color = style.text.comment;
							font_style = "italic";
						};
						error = {
							color = style.text.syntax.error;
						};
						function = {
							color = style.text.heading;
							font_style = "oblique";
						};
						keyword = {
							color = style.text.syntax.error;
							weight = 700;
						};
						number = {
							color = style.text.heading;
						};
						operator = {
							color = style.text.syntax.error;
						};
						property = {
							color = style.text.heading;
						};
						punctuation = {
							color = style.text.dimmed;
						};
						string = {
							color = style.text.light;
						};
						type = {
							color = style.text.syntax.error;
						};
						variable = {
							color = style.text.main;
						};
					};
				};
			}
		];
	};
in {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: {
			xdg.configFile."zed/themes/theMe.json".text = builtins.toJSON themeData;

			programs.zed-editor = {
				enable = true;
				userSettings = {
					theme = {
						mode = "dark";
						light = "theMe";
						dark = "theMe";
					};
				};
			};
		};
	};
}
