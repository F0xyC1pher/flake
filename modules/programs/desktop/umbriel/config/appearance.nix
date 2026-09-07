{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {lib, ...}: {
			programs.umbriel.settings = {
				colors = {
					background = "#141419FF";
					text_primary = "#E8E8EAFF";
					text_muted = "#8A8A92FF";
					accent_primary = "#7AA3FFFF";
					accent_secondary = "#F5C96BFF";
					warning = "#F5C96BFF";
					error = "#FF6B6BFF";
					insert_hint = "#7FC8FF80";
					backdrop = "#000000FF";
					shadow = "#0000007F";
					border = {
						focused = "#7AA3FFFF";
						unfocused = "#292933FF";
						scratchpad_focused = "#E5C07BFF";
						scratchpad_unfocused = "#5C4A2AFF";
						outer = "#1A1A1FFF";
					};
					overview = {
						background_tint = "#10101430";
						workspace_background = "#00000044";
						badge = "#7AA3FFFF";
					};
				};

				appearance = {
					prefer_no_csd = false;
					border_width = 2;
					outer_border_width = 0;
					corner_radius = 0;
					drag_opacity = 0.66;
					blur = {
						enabled = vars.theme.blur.enable or true;
						optimized = vars.theme.blur.xray.enable or false;
						passes = 5;
						radius = 1;
						noise = 0;
						brightness = 1;
						contrast = 1;
						saturation = 1;
					};
					shadow = {
						enabled = true;
						softness = 10;
						offset_x = 2;
						offset_y = 2;
					};
				};

				overview = {
					zoom = 0.5;
					background_blur = true;
					workspace_wallpaper = true;
					shortcuts = true;
					shortcut_keys = "1234567890";
				};

				hot_corners.top_left = {
					enabled = true;
					delay_ms = 66;
					action = "overview-toggle";
				};
			};
		};
	};
}
