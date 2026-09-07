{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {lib, ...}: {
			programs.umbriel = {
				enable = true;
				settings = {
					general = {
						xwayland = true;
						# general.autostart = ["noctalia"];
					};
					layout.gap = 5;
					input.keyboard = {
						layout = "us,ru";
						options = "grp:lalt_lshift_toggle";
						repeat_rate = 30;
						repeat_delay = 400;
					};
					input.focus = {
						follows_mouse = false;
					};
					keybinds = {
						"Mod+Return" = "spawn:kitty";
						"Mod+Q" = "window-close";
						"Mod+D" = "spawn:fuzzel";
						"Mod" = "spawn:noctalia msg panel-toggle launcher";
						"Mod+Left" = "window-focus-left";
						"Mod+Down" = "window-focus-down";
						"Mod+Up" = "window-focus-up";
						"Mod+Right" = "window-focus-right";

						# Window state and layout
						"Mod+T" = "window-toggle-floating";
						"Mod+Shift+T" = "window-focus-switch-floating";
						"Mod+P" = "window-toggle-pinned";
						"Mod+M" = "window-toggle-maximize-to-edges";

						# Overview
						"Mod+O" = {
							action = "overview-toggle";
							repeat = false;
						};
						# These useful bindings are built in already. They stay commented here so an
						# included keybind file can override them without this main file winning again.
						# Uncomment a chord only when this file should own that override.

						"Mod+Escape" = "session-quit";
						"Mod+F1" = "window-focus-next";
						"Mod+H" = "window-focus-left";
						"Mod+J" = "window-focus-down";
						"Mod+K" = "window-focus-up";
						"Mod+L" = "window-focus-right";
						"Mod+Shift+Left" = "column-move-left";
						"Mod+Shift+Down" = "window-move-down";
						"Mod+Shift+Up" = "window-move-up";
						"Mod+Shift+Right" = "column-move-right";
						"Mod+F" = "window-toggle-fullscreen";
						"Mod+Ctrl+F" = "window-toggle-maximize";
						"Mod+R" = "window-cycle-width";
						"Mod+Shift+R" = "window-cycle-width-back";
						"Mod+Comma" = "window-consume-left";
						"Mod+Period" = "window-consume-right";
						"Mod+WheelUp" = "window-focus-left";
						"Mod+WheelDown" = "window-focus-right";
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
						# Mod+1 through Mod+9 switch workspaces. Adding Shift moves the focused window;
						# keypad digits provide the same built-in actions.

						# Scratchpads
						# Each output owns a separate scratchpad. Bare actions target the output under
						# the pointer; append `:DP-1` or a monitor Config name to target one explicitly.
						# Documentation: https://docs.noctalia.dev/umbriel/scratchpads/
						"Mod+Shift+Space" = "window-move-to-scratchpad";
						"Mod+Space" = "scratchpad-toggle";
						"Mod+Ctrl+Space" = "window-restore-from-scratchpad";
						"Mod+Tab" = "scratchpad-focus-next";

						# Optional navigation and sizing recipes. These chords do not replace active
						# bindings above when uncommented.
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
						# "Mod+Minus" = "window-modify-width:-0.1"
						# "Mod+Equal" = "window-modify-width:0.1"
						# "Mod+Alt+Minus" = "window-modify-height:-0.1"
						# "Mod+Alt+Equal" = "window-modify-height:0.1"
						# "Mod+Alt+R" = "window-cycle-height"
						# "Mod+Alt+Shift+R" = "window-cycle-height-back"
						# "Mod+Grave" = "window-focus-last"
						# "Mod+BackSpace" = "window-consume-or-expel-left"
						"Mod+C" = "column-center";
						"Mod+Shift+C" = "window-center";
						# "Mod+Ctrl+T" = "workspace-set-layout:toggle"
						"Mod+MouseMiddle" = "layout-scroll-drag";
						# "Mod+Alt+K" = "keyboard-layout-next"
						# "Mod+WheelUp" = { action = "workspace-previous", cooldown_ms = 150 }
						# "Mod+WheelDown" = { action = "workspace-next", cooldown_ms = 150 }

						# Submaps temporarily replace the active keybind layer and can nest. Entry
						# binds must not repeat. A table-form bind can run an action and then reset one
						# level, while a global reset provides an emergency exit from any layer.
						# Submaps: https://docs.noctalia.dev/umbriel/keybinds/#submaps
						# "Mod+S" = { action = "submap:resize", repeat = false }
						# "submap[resize],1" = { action = "window-set-width:0.5", submap = "reset" }
						# "submap[resize],N" = { action = "submap:nudge", repeat = false }
						# "submap[resize],Escape" = "submap:reset"
						# "submap[nudge],Left" = "window-modify-width:-0.1"
						# "submap[nudge],Right" = "window-modify-width:0.1"
						# "submap[nudge],Escape" = "submap:reset"
						# "Escape" = "submap:reset"

						# Media and brightness
						# Documentation: https://docs.noctalia.dev/umbriel/keybinds/#example-media-and-brightness-keys
						# "XF86AudioRaiseVolume" = "spawn:wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
						# "XF86AudioLowerVolume" = "spawn:wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
						# "XF86AudioMute" = "spawn:wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
						# "XF86AudioPlay" = "spawn:playerctl play-pause"
						# "XF86AudioNext" = "spawn:playerctl next"
						# "XF86AudioPrev" = "spawn:playerctl previous"
						# Binds intended to work while locked use the table form.
						# "XF86MonBrightnessDown" = { action = "spawn:noctalia msg brightness-down 10", allow_when_locked = true }
						# "XF86MonBrightnessUp" = { action = "spawn:noctalia msg brightness-up 10", allow_when_locked = true }
					};
				};
			};
		};
	};
}
