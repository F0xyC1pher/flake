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
					scrollbar = "always";
					scrollbar_interactive = true;
					scrollbar_jump_on_click = true;
					mouse_hide_wait = 0;
					detect_urls = true;
					show_hyperlink_targets = true;
					repaint_delay = 5;
					input_delay = 0;
					enable_audio_bell = true;
					remember_window_size = false;
					remember_window_position = false;
					window_border_width = "1";
					draw_minimal_borders = true;
					draw_window_borders_for_single_window = false; #fatasstetoplush
					window_padding_width = "20 20";
					single_window_padding_width = -1;
					window_margin_width = "0 0";
					single_window_margin_width = -1;
					placement_strategy = "center";
					hide_window_decorations = true;
					# resize_in_steps = true;
					confirm_os_window_close = "0";
					background_opacity = "0.6";
					background_blur = lib.mkIf (vars.blur.enable) 1;

					tab_bar_edge = "bottom"; # top
					tab_bar_style = "powerline"; # fade separator powerline custom
					tab_bar_min_tabs = 1;
					# tab_title_template = "{title}"; # можно кастомизировать
				};
			};
		};
	};
	imports = [
		./theme.nix
		./keybinds.nix
	];
}
