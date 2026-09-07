{
	inputs,
	pkgs,
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
					"background.appearance" = "transparent";
					"background" = "${style.ui.bg}${vars.theme.opacityHex}";
					"border" = "${style.ui.border.inactive}${vars.theme.opacityHex}";
					"border.focused" = style.ui.border.active;
					"surface.background" = "${style.ui.bg}${vars.theme.opacityHex}";

					"title_bar.background" = "${style.ui.bg}${vars.theme.opacityHex}";
					"title_bar.inactive_background" = "${style.ui.bg}${vars.theme.opacityHex}";
					"toolbar.background" = "${style.ui.bg}00";

					"editor.active_line.background" = "${style.ui.border.inactive}${vars.theme.opacityHex}";
					"editor.active_line_number" = style.text.heading;
					"editor.background" = "${style.ui.bg}00";
					"editor.gutter.background" = "${style.ui.bg}00";
					"editor.line_number" = style.text.comment;

					"drop_target.background" = "${style.ui.bg}00";
					"file_scan.background" = "${style.ui.bg}00";
					"panel.background" = "${style.ui.bg}00";
					"panel.focused_border" = style.ui.border.active;
					"project_panel.background" = "${style.ui.bg}00";

					"status_bar.background" = "${style.ui.bg}${vars.theme.opacityHex}";
					"tab.active_background" = "${style.ui.surface}${vars.theme.opacityHex}";
					"tab.inactive_background" = "${style.ui.bg}00";
					"tab_bar.background" = "${style.ui.bg}00";

					"element.hover" = "${style.ui.surface}${vars.theme.opacityHex}";
					"element.selected" = "${style.ui.border.active}${vars.theme.opacityHex}";
					"ghost_element.background" = "${style.ui.bg}00";
					"ghost_element.hover" = "${style.ui.surface}${vars.theme.opacityHex}";
					"ghost_element.selected" = "${style.ui.border.active}${vars.theme.opacityHex}";
					"list.active_item" = "${style.ui.surface}${vars.theme.opacityHex}";
					"list.hover_item" = "${style.ui.surface}${vars.theme.opacityHex}";
					"list.inactive_item" = "${style.ui.bg}00";

					"text" = style.text.main;
					"text.accent" = style.ui.border.active;
					"text.muted" = style.text.dimmed;

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

	zedSettings = {
		theme = {
			mode = "dark";
			light = "theMe";
			dark = "theMe";
		};
		buffer_font_family = vars.theme.font.name;
		ui_font_family = vars.theme.font.name;
		buffer_font_size = vars.theme.font.size;
		ui_font_size = vars.theme.font.size;
		agent_ui_font_size = vars.theme.font.size;
		text_rendering_mode = "subpixel";
		"experimental.font_fallbacks" = ["Noto Color Emoji"];

		disable_ai = true;
		telemetry = {
			diagnostics = false;
			metrics = false;
			anthropic_retention = false;
		};

		icon_theme = "Material Icon Theme";
		rounded_selection = false;
		cli_default_open_behavior = "existing_window";
		project_panel = {dock = "left";};
		scrollbar = {show = "never";};
		completion_menu_scrollbar = "never";
		completion_menu_item_kind = "off";

		autosave = "off";
		hard_tabs = true;
		colorize_brackets = true;
		code_lens = "on";
		snippet_sort_order = "inline";
		show_completions_on_input = true;
		show_completion_documentation = true;
		auto_signature_help = false;
		show_signature_help_after_edits = false;
		inline_code_actions = true;
		diagnostics_max_severity = null;
		lsp_document_colors = "inlay";
		lsp_document_links = true;

		inlay_hints = {enabled = true;};
		indent_guides = {coloring = "indent_aware";};
		minimap = {show = "always";};

		terminal = {
			shell = {
				program = vars.user.shell;
			};
			font_family = vars.theme.font.name;
			font_size = vars.theme.font.size;
		};

		lsp = {
			vscode-css-language-server = {
				binary = {
					path = "${pkgs.vscode-langservers-extracted}/bin/vscode-css-language-server";
					args = ["--stdio"];
				};
			};
			color-lsp = {
				binary = {
					path = "color-lsp";
					args = ["--stdio"];
				};
				initialization_options = {
					userLanguages = {
						nix = "css";
					};
				};
			};
			nixd = {
				binary = {path = "nixd";};
				settings = {
					nixd = {
						formatting = {command = ["alejandra"];};
						options = {
							nixos = {
								expr = "(builtins.getFlake \"/home/${vars.user.name}/flake\").nixosConfigurations.${vars.host}.options";
							};
						};
					};
				};
			};
		};

		languages = {
			Nix = {
				language_servers = ["nixd" "vscode-css-language-server" "!nil"];
				formatter = {external = {command = "alejandra";};};
				format_on_save = "on";
			};
			CSS = {language_servers = ["color-lsp"];};
			HTML = {language_servers = ["color-lsp"];};
			JavaScript = {language_servers = ["color-lsp"];};
			TypeScript = {language_servers = ["color-lsp"];};
		};
	};
in {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: {
			xdg.configFile."zed/themes/theMe.json".text = builtins.toJSON themeData;
			xdg.configFile."zed/settings.json".text = builtins.toJSON zedSettings;

			programs.zed-editor = {
				enable = true;
			};
		};
	};
}
