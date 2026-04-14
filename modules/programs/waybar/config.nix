{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			programs.waybar.settings = {
				mainBar = {
					layer = "top";
					position = "top";
					height = 40;
					spacing = 3;
					"margin-bottom" = -15;

					modules-left = [
						"group/left-hidden"
						"niri/language"
					];

					modules-center = ["niri/workspaces"];

					modules-right = [
						"custom/notification"
						"network"
						"group/right-hidden"
						"clock"
						"tray"
					];
					"group/left-hidden" = {
						"orientation" = "horizontal";
						"drawer" = {
							"transition-duration" = 500;
							"transition-left-to-right" = true;
							"click-to-reveal" = true;
						};
						"modules" = [
							"custom/arrow-right"
							"backlight"
							"bluetooth"
							"wireplumber"
							"wireplumber#source"
						];
					};
					"custom/arrow-right" = {
						"format" = "";
						"tooltip" = false;
						"cursor" = true;
					};

					"group/right-hidden" = {
						"orientation" = "horizontal";
						"drawer" = {
							"transition-duration" = 500;
							"transition-left-to-right" = false;
							"click-to-reveal" = true;
						};
						"modules" = [
							"custom/arrow-left"
							"battery"
							"memory"
							"cpu"
						];
					};
					"custom/arrow-left" = {
						"format" = "";
						"tooltip" = false;
						"cursor" = true;
					};

					backlight = {
						device = "intel_backlight";
						format = "{icon} {percent}%";
						format-icons = [" " " "];
					};

					wireplumber = {
						format = "{icon} {volume}%";
						format-icons.default = ["󰕿" "󰖀" "󰕾"];
						format-muted = "󰝟 mute";
						on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
						scroll-step = 2.5;
						max-volume = 100.0;
					};

					"wireplumber#source" = {
						"node-type" = "Audio/Source";
						format = "󰍬 {volume}%";
						format-muted = "󰍭 mute";
						"on-click-right" = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
						scroll-step = 2.5;
					};

					battery = {
						format = "{icon} {capacity}%";
						format-alt = "{icon} {time}";
						format-charging = "󰂅 {capacity}%";
						format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
						states = {
							critical = 15;
							warning = 30;
						};
					};

					"niri/workspaces" = {
						on-click = "activate";
						current-only = false;
						format = "{icon}";
						format-icons = {
							"1" = "一";
							"2" = "二";
							"3" = "三";
							"4" = "四";
							"5" = "五";
							"6" = "六";
							"7" = "七";
							"8" = "八";
							"9" = "九";
							"10" = "十";
							"11" = "一";
						};
						persistent-workspaces = {
							"DVI-D-1" = ["1" "2" "3" "4" "5" "6" "7" "8" "9" "10"];
						};
					};

					"niri/language" = {
						format = "Язык: {}";
						format-en = "🇺🇸 EN";
						format-ru = "🇷🇺 RU";
						interval = 1;
					};

					tray = {
						icon-size = 24;
						spacing = 10;
						show-passive-items = true;
					};

					"custom/notification" = {
						tooltip = false;
						format = "{icon}";
						format-icons = {
							notification = "<span foreground='red'><sup></sup></span>";
							none = "";
							"dnd-notification" = "<span foreground='red'><sup></sup></span>";
							"dnd-none" = "";
							"inhibited-notification" = "<span foreground='red'><sup></sup></span>";
							"inhibited-none" = "";
							"dnd-inhibited-notification" = "<span foreground='red'><sup></sup></span>";
							"dnd-inhibited-none" = "";
						};
						return-type = "json";
						exec-if = "which swaync-client";
						exec = "swaync-client -swb";
						on-click = "sleep 0.1s && swaync-client -t -sw";
						on-click-right = "swaync-client -d -sw";
						escape = true;
					};

					clock = {
						interval = 1;
						locale = "ru_RU.UTF-8";
						format = "{:%H:%M:%S}";
						format-alt = "{:%A, %b %d} ";
						tooltip-format = "<tt><small>{calendar}</small></tt>";
						calendar = {
							mode = "year";
							mode-mon-col = 3;
							weeks-pos = "right";
							format = {
								months = "<span color='${vars.style.theme.subtext}'><b>{}</b></span>";
								days = "<span color='${vars.style.theme.fgMain}'><b>{}</b></span>";
								weekdays = "<span color='${vars.style.colors.y0}'><b>{}</b></span>";
								today = "<span color='${vars.style.theme.accent}'><b><u>{}</u></b></span>";
							};
						};
					};

					cpu = {
						interval = 2;
						format = "{load:.0f}% "; # целое число: 1% вместо 0.7% или 0.58%
						on-click = "kitty btop";
						on-click-right = "kitty btop";
					};

					memory = {
						interval = 2;
						format = "{}% 󰍛";
						on-click = "kitty btop";
						on-click-right = "cliphist list | rofi -dmenu -normal-window | cliphist decode | wl-copy";
					};

					network = {
						interval = 2;
						format-wifi = "{gwaddr} ({signalStrength}%)";
						format-ethernet = "{gwaddr}";
						format-linked = "No IP ({ifname})";
						format-disconnected = "Disconnected";
						# tooltip-format = "{ifname} {ipaddr}/{cidr} via {gwaddr}";
						# format-alt = "↓{bandwidthDownBytes} ↑{bandwidthUpBytes}";
						on-click-right = "~/.config/niri/scripts/networkmanager_dmenu";
					};
				};
			};
		};
	};
}
