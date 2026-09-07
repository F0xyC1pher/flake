{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {lib, ...}: {
			programs.umbriel.settings.keybinds = {
				"Mod+Return" = "spawn:kitty";
				"Mod+Q" = "window-close";
				"Mod+D" = "spawn:fuzzel";
				"Mod" = "spawn:noctalia msg panel-toggle launcher";

				# Window state and layout
				"Mod+T" = "window-toggle-floating";
				"Mod+Shift+T" = "window-focus-switch-floating";
				"Mod+P" = "window-toggle-pinned";
				"Mod+M" = "window-toggle-maximize-to-edges";

				# Overview
				"Mod+Tab" = {
					action = "overview-toggle";
					repeat = false;
				};

				"Mod+Escape" = "session-quit";
				"Mod+F1" = "window-focus-next";
				"Mod+Left" = "window-focus-left";
				"Mod+Down" = "window-focus-or-workspace-down";
				"Mod+Up" = "window-focus-or-workspace-up";
				"Mod+Right" = "window-focus-right";
				"Mod+Shift+Left" = "column-move-left";
				"Mod+Shift+Down" = "window-move-or-workspace-down";
				"Mod+Shift+Up" = "window-move-or-workspace-up";
				"Mod+Shift+Right" = "column-move-right";

				"Mod+H" = "window-focus-left";
				"Mod+J" = "window-focus-or-workspace-down";
				"Mod+K" = "window-focus-or-workspace-up";
				"Mod+L" = "window-focus-right";
				"Mod+Shift+H" = "window-focus-left";
				"Mod+Shift+J" = "window-move-or-workspace-down";
				"Mod+Shift+K" = "window-move-or-workspace-up";
				"Mod+Shift+L" = "window-focus-right";
				"Mod+F" = "window-toggle-fullscreen";
				"Mod+Ctrl+F" = "window-toggle-maximize";
				"Mod+R" = "window-cycle-width";
				"Mod+Shift+R" = "window-cycle-width-back";
				"Mod+Comma" = "window-consume-left";
				"Mod+Period" = "window-consume-right";
				"Mod+Shift+WheelUp" = "window-focus-left";
				"Mod+Shift+WheelDown" = "window-focus-right";
				"Mod+WheelUp" = {
					action = "workspace-previous";
					cooldown_ms = 66;
				};
				"Mod+WheelDown" = {
					action = "workspace-next";
					cooldown_ms = 66;
				};
				"Mod+1" = "workspace-switch:1";
				"Mod+2" = "workspace-switch:2";
				"Mod+3" = "workspace-switch:3";
				"Mod+4" = "workspace-switch:4";
				"Mod+5" = "workspace-switch:5";
				"Mod+6" = "workspace-switch:6";
				"Mod+7" = "workspace-switch:7";
				"Mod+8" = "workspace-switch:8";
				"Mod+9" = "workspace-switch:9";
				"Mod+0" = "workspace-switch:10";
				"Mod+Shift+1" = "window-move-to-workspace:1";
				"Mod+Shift+2" = "window-move-to-workspace:2";
				"Mod+Shift+3" = "window-move-to-workspace:3";
				"Mod+Shift+4" = "window-move-to-workspace:4";
				"Mod+Shift+5" = "window-move-to-workspace:5";
				"Mod+Shift+6" = "window-move-to-workspace:6";
				"Mod+Shift+7" = "window-move-to-workspace:7";
				"Mod+Shift+8" = "window-move-to-workspace:8";
				"Mod+Shift+9" = "window-move-to-workspace:9";
				"Mod+Shift+0" = "window-move-to-workspace:10";
				"Mod+Ctrl+Shift+1" = "column-move-to-workspace:1";
				"Mod+Ctrl+Shift+2" = "column-move-to-workspace:2";
				"Mod+Ctrl+Shift+3" = "column-move-to-workspace:3";
				"Mod+Ctrl+Shift+4" = "column-move-to-workspace:4";
				"Mod+Ctrl+Shift+5" = "column-move-to-workspace:5";
				"Mod+Ctrl+Shift+6" = "column-move-to-workspace:6";
				"Mod+Ctrl+Shift+7" = "column-move-to-workspace:7";
				"Mod+Ctrl+Shift+8" = "column-move-to-workspace:8";
				"Mod+Ctrl+Shift+9" = "column-move-to-workspace:9";
				"Mod+Ctrl+Shift+0" = "column-move-to-workspace:10";

				# Scratchpads
				"Mod+Shift+Space" = "window-move-to-scratchpad";
				"Mod+Space" = "scratchpad-toggle";
				"Mod+Ctrl+Space" = "window-restore-from-scratchpad";
				"Mod+Ctrl+Tab" = "scratchpad-focus-next";

				"Mod+Page_Up" = "workspace-previous";
				"Mod+Page_Down" = "workspace-next";
				"Mod+Shift+Page_Up" = "window-move-to-workspace-previous";
				"Mod+Shift+Page_Down" = "window-move-to-workspace-next";
				"Mod+Home" = "column-focus-first";
				"Mod+End" = "column-focus-last";
				"Mod+Shift+Home" = "column-move-to-first";
				"Mod+Shift+End" = "column-move-to-last";
				"Mod+Bracketright" = "window-focus-next";
				"Mod+Bracketleft" = "window-focus-previous";
				"Mod+Shift+Bracketright" = "window-swap-next";
				"Mod+Shift+Bracketleft" = "window-swap-previous";
				"Mod+C" = "column-center";
				"Mod+Shift+C" = "window-center";
				"Mod+MouseMiddle" = "layout-scroll-drag";
			};
		};
	};
}
