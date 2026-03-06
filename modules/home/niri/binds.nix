{ lib, config, pkgs, inputs, vars, ... }:
{
	# ========== NIRI ==========
	programs.niri = {
		settings = {
			binds = {
				"Mod+Shift+Slash" = { action.show-hotkey-overlay = {}; };
				
				"Mod+Q" = { action.close-window = {}; };
				"Mod+Tab" = { action.toggle-overview = {}; };
				"Mod+Return" = { action.spawn = [ "kitty" ]; };
				"Mod+T" = { action.spawn = [ "kitty" ]; };
				"MOD+Y" = { action.spawn = [ "kitty" "yazi" ]; hotkey-overlay.title = "File Manager: Yazi"; };
				"Mod+R" = { action.spawn-sh = [ "rofi -show drun" ]; };
				"Mod+Alt+L" = { action.spawn = [ "swaylock" ]; };
				
				"Mod+1" = { action.focus-workspace = 1; };
				"Mod+2" = { action.focus-workspace = 2; };
				"Mod+3" = { action.focus-workspace = 3; };
				"Mod+4" = { action.focus-workspace = 4; };
				"Mod+5" = { action.focus-workspace = 5; };
				"Mod+6" = { action.focus-workspace = 6; };
				"Mod+7" = { action.focus-workspace = 7; };
				"Mod+8" = { action.focus-workspace = 8; };
				"Mod+9" = { action.focus-workspace = 9; };
				
				"Mod+Shift+1" = { action.move-column-to-workspace = 1; };
				"Mod+Shift+2" = { action.move-column-to-workspace = 2; };
				"Mod+Shift+3" = { action.move-column-to-workspace = 3; };
				"Mod+Shift+4" = { action.move-column-to-workspace = 4; };
				"Mod+Shift+5" = { action.move-column-to-workspace = 5; };
				"Mod+Shift+6" = { action.move-column-to-workspace = 6; };
				"Mod+Shift+7" = { action.move-column-to-workspace = 7; };
				"Mod+Shift+8" = { action.move-column-to-workspace = 8; };
				"Mod+Shift+9" = { action.move-column-to-workspace = 9; };
				
				"Mod+Up" = { action.focus-window-or-workspace-up = {}; };
				"Mod+Down" = { action.focus-window-or-workspace-down = {}; };
				"Mod+Left" = { action.focus-column-left = {}; };
				"Mod+Right" = { action.focus-column-right = {}; };
				"Mod+Shift+Up" = { action.move-window-up-or-to-workspace-up = {}; };
				"Mod+Shift+Down" = { action.move-window-down-or-to-workspace-down = {}; };
				"Mod+Shift+Left" = { action.move-column-left = {}; };
				"Mod+Shift+Right" = { action.move-column-right = {}; };
				
				"Mod+Home" = { action.focus-column-first = {}; };
				"Mod+End" = { action.focus-column-last = {}; };
				"Mod+Ctrl+Home" = { action.move-column-to-first = {}; };
				"Mod+Ctrl+End" = { action.move-column-to-last = {}; };
				
				"Mod+Page_Down" = { action.focus-workspace-down = {}; };
				"Mod+Page_Up" = { action.focus-workspace-up = {}; };
				"Mod+Shift+Page_Down" = { action.move-window-to-workspace-down = {}; };
				"Mod+Shift+Page_Up" = { action.move-window-to-workspace-up = {}; };
				
				"Mod+Ctrl+Page_Down" = { action.move-workspace-down = {}; };
				"Mod+Ctrl+Page_Up" = { action.move-workspace-up = {}; };
				
				"Mod+WheelScrollRight" = { action.focus-column-right = {}; };
				"Mod+WheelScrollLeft" = { action.focus-column-left = {}; };
				"Mod+Ctrl+WheelScrollRight" = { action.move-column-right = {}; };
				"Mod+Ctrl+WheelScrollLeft" = { action.move-column-left = {}; };
				
				"Mod+Shift+WheelScrollDown" = { action.focus-column-right = {}; };
				"Mod+Shift+WheelScrollUp" = { action.focus-column-left = {}; };
				"Mod+Ctrl+Shift+WheelScrollDown" = { action.move-column-right = {}; };
				"Mod+Ctrl+Shift+WheelScrollUp" = { action.move-column-left = {}; };
				
				"Mod+F" = { action.maximize-column = {}; };
				"Mod+Shift+F" = { action.fullscreen-window = {}; };
				"Mod+space" = { action.toggle-window-floating = {}; };
				"Mod+Shift+space" = { action.switch-focus-between-floating-and-tiling = {}; };
				"Print" = { action.screenshot = {}; };
				"Ctrl+Mod+Alt+Q" = { action.quit = {}; };
				"Ctrl+Alt+Delete" = { action.quit = {}; };
				"Mod+Shift+P" = { action.power-off-monitors = {}; };
			};
		};
	};
}
