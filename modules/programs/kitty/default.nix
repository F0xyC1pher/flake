{
	inputs,
	vars,
	lib,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			programs.kitty = {
				enable = true;
				enableGitIntegration = true;
				shellIntegration.enableFishIntegration = true;
				font = {
					name = "${vars.fontName}";
					size = vars.fontSize;
				};
				settings = {
					sync_to_monitor = true;
					pixel_scroll = true;
					# scrollbar = "always";
					# scrollbar_interactive = true;
					# scrollbar_jump_on_click = true;
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
					draw_window_borders_for_single_window = false; #fatasstetoplush
					# cursor_trail = "200";
					# cursor_trail_decay = "0.1 0.4";
					# cursor_trail_start_threshold = "2";
					# window_margin_width = "10 10 10 10"; # blank area outside the border
					# single_window_margin_width = -1;
					window_padding_width = "15 20 15 20"; # blank area between the text and the window border
					single_window_padding_width = -1;
					placement_strategy = "center";
					hide_window_decorations = true;
					# resize_in_steps = true;
					confirm_os_window_close = "0";
					background_opacity = "0.6";
					background_blur = lib.mkIf (vars.blur.enable) 1;
					# tab_bar_edge = "bottom"; # top
					# tab_bar_style = "powerline"; # fade separator slant powerline custom
					# tab_powerline_style = "angled"; # angled slanted round
					# tab_separator = "|";
					# tab_bar_margin_width = "0.0";
					# active_tab_font_style = "bold";
					# tab_bar_margin_height = "0.0 0.0"; # The margin above and below the tab bar (in pts).
					# inactive_tab_font_style = "normal";
					# The first number is the margin between the edge of the OS Window and the tab bar.
					# The second number is the margin between the tab bar and the contents of the current tab.
					# tab_bar_align= "left";
					# tab_bar_min_tabs = 1;
					# tab_title_template = "{num_windows} {title}"; # можно кастомизировать
					tab_bar_custom_draw = "~/.config/kitty/tab_bar.py";
					tab_bar_edge = "bottom";
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
				};
			};
		};
	};
	imports = [
		./keybinds.nix
		./tab_bar.nix
		./theme.nix
	];
}
