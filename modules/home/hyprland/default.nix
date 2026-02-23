{ lib, config, pkgs, inputs, vars, ... }:
{
	wayland.windowManager.hyprland = {
		enable = true;
		systemd.enable = true;
		xwayland.enable = true;
		plugins = with inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}; [
			csgo-vulkan-fix
		];
		settings = {
#			decoration = {
#				shadow_offset = "0 5";
#				"col.shadow" = "rgba(00000099)";
#			};
			 
			"$mod" = "SUPER";
			
			bind = [
#				Execute Rofi with only the SUPER key
				"$mod, Super_L, exec, pkill rofi || rofi -show drun"
				 
				"$mod, left, movefocus, l"
				"$mod, right, movefocus, r"
				"$mod, up, movefocus, u"
				"$mod, down, movefocus, d"
				"$mod, 1, workspace, 1"
				"$mod, 2, workspace, 2"
				"$mod, 3, workspace, 3"
				"$mod, 4, workspace, 4"
				"$mod, 5, workspace, 5"
				"$mod, 6, workspace, 6"
				"$mod, 7, workspace, 7"
				"$mod, 8, workspace, 8"
				"$mod, 9, workspace, 9"
				"$mod, 0, workspace, 10"
				"$mod SHIFT, 1, movetoworkspace, 1"
				"$mod SHIFT, 2, movetoworkspace, 2"
				"$mod SHIFT, 3, movetoworkspace, 3"
				"$mod SHIFT, 4, movetoworkspace, 4"
				"$mod SHIFT, 5, movetoworkspace, 5"
				"$mod SHIFT, 6, movetoworkspace, 6"
				"$mod SHIFT, 7, movetoworkspace, 7"
				"$mod SHIFT, 8, movetoworkspace, 8"
				"$mod SHIFT, 9, movetoworkspace, 9"
				"$mod SHIFT, 0, movetoworkspace, 10"
				
				# ""
				"$mod, space, togglefloating,"
				
				"$mod, Q, exec, killactive,"
				"$mod, T, exec, kitty,"
				"$mod, Return, exec, kitty,"
				"CTRL $mod ALT, Q, exec, command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"
			];
			
#			Startup Apps
#			exec-once = [
#				 "waybar"
#			];
			
			bindm = [
				# mouse movements
				"$mod, mouse:272, movewindow"
				"$mod, mouse:273, resizewindow"
				# "$mod ALT, mouse:272, resizewindow"
			];
		};
	};
}
