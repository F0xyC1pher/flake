{ lib, config, pkgs, inputs, vars, ... }:
{
home-manager = {
	extraSpecialArgs = { inherit inputs vars; };
	users.${vars.userName} =  { config, pkgs, lib, ... }: {
		programs.waybar = {
			enable = true;
			systemd.enable = true;
			settings = [{
				height = 1;
				layer = "top";
				position = "top";
				
				modules-left = [ "backlight" "wireplumber" "wireplumber#source" "niri/language" "bluetooth" ];
				modules-center = [ "niri/workspaces" ];
				modules-right = [ "tray" "clock#time" "custom/clock" "battery" ];
				
				backlight = {
					device = "intel_backlight";
					format = "{icon} {percent}%";
					format-icons = [ " " " " ];
				};
				bluetooth = {
					format = "󰂯 {status}";
					format-connected = "󰂯 {device_battery_percentage}%";
					tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
					tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
					tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
					tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
				};
				tray = {
					icon-size = 18;
					spacing = 12;
				};
				battery = {
					format = "{icon} {capacity}%";
					format-alt = "{icon} {time} ";
					format-charging = "󰂅 {capacity}%";
					format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
					states = {
						critical = 15;
						warning = 30;
					};
				};
				"clock#time" = {
					format = "󰸘 {:%b %e}";
					tooltip-format = "<tt>{calendar}</tt>";
					interval = 1;
				};
				"custom/clock" = {
					exec = "date +\" %H:%M:%S\"";
					/* • */
					interval = 1;
				};
				"niri/language" = {
					format = "{}";
					format-en = "🇺🇸 EN";
					format-ru = "🇷🇺 RU";
					interval = 1;
				};
				wireplumber = {
					format = "{icon} {volume}%";
					# format-icons = [ "" "" "" ];
					format-icons = {
						default = [ "󰕿" "󰖀" "󰕾" ];
					};
					format-muted = "󰝟 mute";
					on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
					scroll-step = 2.5;
					max-volume = 100.0;
				};
				"wireplumber#source" = {
					node-type = "Audio/Source";
					format = "󰍬 {volume}%";
					format-muted = "󰍭 mute";
					on-click-right = "wpctl set-mute @default_audio_source@ toggle";
					scroll-step = 2.5;
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
						"DVI-D-1" = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" ];
					};
				};
			}];
		};
	};
}
