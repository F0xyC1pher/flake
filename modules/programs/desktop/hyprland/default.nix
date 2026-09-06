{
	pkgs,
	lib,
	inputs,
	vars,
	...
}: let
	lua = lib.generators.mkLuaInline;
	mainMod = vars.system.modKey;
in {
	home-manager.users.${vars.user.name} = {
		wayland.windowManager.hyprland = {
			enable = true;

			package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
			xwayland.enable = true;

			settings = {
				# ----------------------------------------------------------------------
				# MONITORS & ENV
				# ----------------------------------------------------------------------
				monitor = [
					{
						output = "";
						mode = "preferred";
						position = "auto";
						scale = "auto";
					}
				];

				env = [
					{_args = ["XCURSOR_SIZE" "24"];}
					{_args = ["HYPRCURSOR_SIZE" "24"];}
				];

				# ----------------------------------------------------------------------
				# CONFIG (General, Decoration, Layouts, Input, Misc)
				# ----------------------------------------------------------------------
				config = [
					{
						general = {
							gaps_in = 5;
							gaps_out = 20;
							border_size = 2;
							col = {
								active_border = {
									colors = ["rgba(33ccffee)" "rgba(00ff99ee)"];
									angle = 45;
								};
								inactive_border = "rgba(595959aa)";
							};
							resize_on_border = false;
							allow_tearing = false;
							layout = "dwindle";
						};

						decoration = {
							rounding = 0; # Твой параметр отступов
							rounding_power = 2;
							active_opacity = 1.0;
							inactive_opacity = 1.0;
							shadow = {
								enabled = true;
								range = 4;
								render_power = 3;
								color = lua "0xee1a1a1a";
							};
							blur = {
								enabled = true;
								size = 3;
								passes = 1;
								vibrancy = 0.1696;
							};
						};

						animations = {
							enabled = true;
						};

						dwindle = {
							preserve_split = true;
						};

						master = {
							new_status = "master";
						};

						scrolling = {
							fullscreen_on_one_column = true;
						};

						misc = {
							force_default_wallpaper = 0;
							disable_hyprland_logo = true;
						};

						input = {
							kb_layout = "us,ru";
							kb_variant = "";
							kb_model = "";
							kb_options = "grp:lalt_lshift_toggle";
							kb_rules = "";
							follow_mouse = 1;
							sensitivity = 0;
							touchpad = {
								natural_scroll = false;
							};
						};
					}
				];

				# ----------------------------------------------------------------------
				# CURVES & ANIMATIONS (Из референсного файла)
				# ----------------------------------------------------------------------
				curve = [
					{
						_args = [
							"easeOutQuint"
							{
								type = "bezier";
								points = [[0.23 1] [0.32 1]];
							}
						];
					}
					{
						_args = [
							"easeInOutCubic"
							{
								type = "bezier";
								points = [[0.65 0.05] [0.36 1]];
							}
						];
					}
					{
						_args = [
							"linear"
							{
								type = "bezier";
								points = [[0 0] [1 1]];
							}
						];
					}
					{
						_args = [
							"almostLinear"
							{
								type = "bezier";
								points = [[0.5 0.5] [0.75 1]];
							}
						];
					}
					{
						_args = [
							"quick"
							{
								type = "bezier";
								points = [[0.15 0] [0.1 1]];
							}
						];
					}
					{
						_args = [
							"easy"
							{
								type = "spring";
								mass = 1;
								stiffness = 238.1191;
								damping = 24.21279333;
							}
						];
					}
				];

				animation = [
					{
						leaf = "global";
						enabled = true;
						speed = 10;
						bezier = "default";
					}
					{
						leaf = "border";
						enabled = true;
						speed = 5.39;
						bezier = "easeOutQuint";
					}
					{
						leaf = "windows";
						enabled = true;
						speed = 4.79;
						spring = "easy";
					}
					{
						leaf = "windowsIn";
						enabled = true;
						speed = 4.1;
						spring = "easy";
						style = "popin 87%";
					}
					{
						leaf = "windowsOut";
						enabled = true;
						speed = 1.49;
						bezier = "linear";
						style = "popin 87%";
					}
					{
						leaf = "fadeIn";
						enabled = true;
						speed = 1.73;
						bezier = "almostLinear";
					}
					{
						leaf = "fadeOut";
						enabled = true;
						speed = 1.46;
						bezier = "almostLinear";
					}
					{
						leaf = "fade";
						enabled = true;
						speed = 3.03;
						bezier = "quick";
					}
					{
						leaf = "layers";
						enabled = true;
						speed = 3.81;
						bezier = "easeOutQuint";
					}
					{
						leaf = "layersIn";
						enabled = true;
						speed = 4;
						bezier = "easeOutQuint";
						style = "fade";
					}
					{
						leaf = "layersOut";
						enabled = true;
						speed = 1.5;
						bezier = "linear";
						style = "fade";
					}
					{
						leaf = "fadeLayersIn";
						enabled = true;
						speed = 1.79;
						bezier = "almostLinear";
					}
					{
						leaf = "fadeLayersOut";
						enabled = true;
						speed = 1.39;
						bezier = "almostLinear";
					}
					{
						leaf = "workspaces";
						enabled = true;
						speed = 1.94;
						bezier = "almostLinear";
						style = "fade";
					}
					{
						leaf = "workspacesIn";
						enabled = true;
						speed = 1.21;
						bezier = "almostLinear";
						style = "fade";
					}
					{
						leaf = "workspacesOut";
						enabled = true;
						speed = 1.94;
						bezier = "almostLinear";
						style = "fade";
					}
					{
						leaf = "zoomFactor";
						enabled = true;
						speed = 7;
						bezier = "quick";
					}
				];

				# ----------------------------------------------------------------------
				# WINDOW RULES & EXTRA DEVICING
				# ----------------------------------------------------------------------
				window_rule = [
					{
						name = "suppress-maximize-events";
						match = {class = ".*";};
						suppress_event = "maximize";
					}
					{
						name = "fix-xwayland-drags";
						match = {
							class = "^$";
							title = "^$";
							xwayland = true;
							float = true;
							fullscreen = false;
							pin = false;
						};
						no_focus = true;
					}
					{
						name = "move-hyprland-run";
						match = {class = "hyprland-run";};
						move = "20 monitor_h-120";
						float = true;
					}
				];

				gesture = [
					{
						fingers = 3;
						direction = "horizontal";
						action = "workspace";
					}
				];

				device = [
					{
						name = "epic-mouse-v1";
						sensitivity = -0.5;
					}
				];

				# ----------------------------------------------------------------------
				# KEYBINDINGS (Сохранены все твои привязки)
				# ----------------------------------------------------------------------
				bind =
					[
						# Твои бинды приложений
						{_args = ["${mainMod} + T" (lua "hl.dsp.exec_cmd('kitty')")];}
						{_args = ["${mainMod} + Q" (lua "hl.dsp.window.close()")];}
						{_args = ["${mainMod} + M" (lua "hl.dsp.exec_cmd(\"command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'\")")];}
						{_args = ["${mainMod} + Y" (lua "hl.dsp.exec_cmd('yazi')")];}
						{_args = ["${mainMod} + space" (lua "hl.dsp.window.float({ action = 'toggle' })")];}
						{_args = ["${mainMod} + R" (lua "hl.dsp.exec_cmd('fuzzel')")];}
						{_args = ["${mainMod} + P" (lua "hl.dsp.window.pseudo()")];}
						{_args = ["${mainMod} + J" (lua "hl.dsp.layout('togglesplit')")];}

						# Навигация
						{_args = ["${mainMod} + left" (lua "hl.dsp.focus({ direction = 'left' })")];}
						{_args = ["${mainMod} + right" (lua "hl.dsp.focus({ direction = 'right' })")];}
						{_args = ["${mainMod} + up" (lua "hl.dsp.focus({ direction = 'up' })")];}
						{_args = ["${mainMod} + down" (lua "hl.dsp.focus({ direction = 'down' })")];}

						# Special workspace (scratchpad)
						{_args = ["${mainMod} + S" (lua "hl.dsp.workspace.toggle_special('magic')")];}
						{_args = ["${mainMod} + SHIFT + S" (lua "hl.dsp.window.move({ workspace = 'special:magic' })")];}

						# Мышь
						{_args = ["${mainMod} + mouse_down" (lua "hl.dsp.focus({ workspace = 'e+1' })")];}
						{_args = ["${mainMod} + mouse_up" (lua "hl.dsp.focus({ workspace = 'e-1' })")];}
						{_args = ["${mainMod} + mouse:272" (lua "hl.dsp.window.drag()") {mouse = true;}];}
						{_args = ["${mainMod} + mouse:273" (lua "hl.dsp.window.resize()") {mouse = true;}];}

						# Громкость и яркость (wpctl + brightnessctl)
						{
							_args = [
								"XF86AudioRaiseVolume"
								(lua "hl.dsp.exec_cmd('wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+')")
								{
									locked = true;
									repeating = true;
								}
							];
						}
						{
							_args = [
								"XF86AudioLowerVolume"
								(lua "hl.dsp.exec_cmd('wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-')")
								{
									locked = true;
									repeating = true;
								}
							];
						}
						{
							_args = [
								"XF86AudioMute"
								(lua "hl.dsp.exec_cmd('wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle')")
								{
									locked = true;
									repeating = true;
								}
							];
						}
						{
							_args = [
								"XF86AudioMicMute"
								(lua "hl.dsp.exec_cmd('wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle')")
								{
									locked = true;
									repeating = true;
								}
							];
						}
						{
							_args = [
								"XF86MonBrightnessUp"
								(lua "hl.dsp.exec_cmd('brightnessctl -e4 -n2 set 5%+')")
								{
									locked = true;
									repeating = true;
								}
							];
						}
						{
							_args = [
								"XF86MonBrightnessDown"
								(lua "hl.dsp.exec_cmd('brightnessctl -e4 -n2 set 5%-')")
								{
									locked = true;
									repeating = true;
								}
							];
						}

						# Управление плеером (playerctl из образца)
						{_args = ["XF86AudioNext" (lua "hl.dsp.exec_cmd('playerctl next')") {locked = true;}];}
						{_args = ["XF86AudioPause" (lua "hl.dsp.exec_cmd('playerctl play-pause')") {locked = true;}];}
						{_args = ["XF86AudioPlay" (lua "hl.dsp.exec_cmd('playerctl play-pause')") {locked = true;}];}
						{_args = ["XF86AudioPrev" (lua "hl.dsp.exec_cmd('playerctl previous')") {locked = true;}];}
					]
					++ (
						# Воркспейсы 1..10 (клавиши 1..9, 0)
						lib.concatLists (lib.genList (i: let
									ws = i + 1;
									key = toString (lib.mod ws 10);
								in [
									{_args = ["${mainMod} + ${key}" (lua "hl.dsp.focus({ workspace = ${toString ws} })")];}
									{_args = ["${mainMod} + SHIFT + ${key}" (lua "hl.dsp.window.move({ workspace = ${toString ws} })")];}
								])
							10)
					);
			};
		};
	};
}
