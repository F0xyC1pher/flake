# ── Kitty terminal ────────────────────────────────────────────────────────────
{
	inputs,
	vars,
	lib,
	...
}: {
	imports = [
		./keybinds.nix
		# ./tab_bar.nix
		./theme.nix
	];

	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: {
			programs.kitty = {
				enable = true;
				enableGitIntegration = true;
				shellIntegration.enableFishIntegration = true;

				font = {
					name = vars.theme.font.name;
					size = vars.theme.font.size;
				};

				settings = {
					sync_to_monitor = true;
					pixel_scroll = true;
					mouse_hide_wait = 0;
					detect_urls = true;
					show_hyperlink_targets = true;
					repaint_delay = 5;
					input_delay = 0;
					enable_audio_bell = true;
					remember_window_size = false;
					remember_window_position = false;

					window_border_width = "1";
					draw_minimal_borders = false;
					draw_window_borders_for_single_window = false;
					window_margin_width = "15 20 15 20";
					single_window_margin_width = -1;
					placement_strategy = "center";
					hide_window_decorations = true;
					confirm_os_window_close = "0";

					background_opacity = "0.6";
					background_blur = lib.mkIf (vars.theme.blur.enable) 16;

					# ── Tab bar ────────────────────────────────────────────────────────
					tab_bar_edge = "top";
					tab_bar_align = "left";
					tab_bar_style = "custom";
					tab_bar_min_tabs = 1;
					tab_activity_symbol = "none";
					bell_on_tab = "no";
					tab_separator = "";
					tab_bar_margin_width = "0.0";
					tab_bar_margin_height = "0.0 0.0";
					tab_title_template = "{f'{title[:30]}…' if title.rindex(title[-1]) + 1 > 30 else (title.center(6) if (title.rindex(title[-1]) + 1) % 2 == 0 else title.center(5))}";
					active_tab_font_style = "bold";
					tab_bar_custom_draw = "~/.config/kitty/tab_bar.py";
				};
			};
		};
	};
}
