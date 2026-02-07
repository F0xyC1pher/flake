{ lib, config, pkgs, inputs, vars, ... }:
{
	programs.waybar = {
		enable = true;
		systemd.enable = true;
		settings = {
			mainBar = {
				layer = "top";
				position = "top";
				height = 30;
				spacing = 4;
				
				modules-left = [ "custom/launcher" "niri/workspaces" ];
				modules-center = [ "niri/window" ];
				modules-right = [ "tray" "niri/language" "pulseaudio" "network" "cpu" "memory" "clock" ];
				
				"custom/launcher" = {
					format = "";
					on-click = "sh -c rofi -show drun";
					tooltip = false;
				};
				
				"niri/workspaces" = {
					format = "{icon}";
					format-icons = {
						"focused"= "󰮯";
						"active"= "󰮯";
						"default"= "󰊠";
						"empty"= "󰝦";
					};
					disable-click = false;
					current-only = false;
					all-outputs = false;
				};
				
				"niri/window" = {
					format = "{title}";
					rewrite = {
						"(.*) - Mozilla Firefox"= "🌎 $1";
						"(.*) - Kitty"= " $1";
						"kitty"= " Terminal";
					};
					separate-outputs = false;
					icon = false;
				};
				
				"niri/language" = {
					format = "{}";
					format-en = "🇺🇸 EN";
					format-ru = "🇷🇺 RU";
					tooltip = false;
				};
				
				"tray" = {
					icon-size = 16;
					spacing = 8;
				};
				
				"pulseaudio" = {
					format = "{volume}% {icon}";
					format-bluetooth = "{volume}% {icon}";
					format-bluetooth-muted = "󰸈 {icon}";
					format-muted = "󰸈";
					format-icons = {
						default = [ "󰕿" "󰖀" "󰕾" ];
					};
					on-click = "pavucontrol";
					tooltip-format = "{desc}";
				};
				
				"network" = {
					format-wifi = "{essid} 󰖩";
					format-ethernet = "󰈀";
					format-disconnected = "󰖪";
					tooltip-format = "{ifname}: {ipaddr}/{cidr}";
					tooltip-format-wifi = "{essid} ({signalStrength}%) 󰖩";
				};
				
				"cpu" = {
					format = "󰍛 {usage}%";
					interval = 2;
					tooltip = false;
				};
				
				"memory" = {
					format = "󰍛 {}%";
					interval = 2;
				};
				
				"clock" = {
					format = "{:%H:%M:%S}";
					tooltip-format = "{:%A, %d %B %Y}\n<tt><small>{calendar}</small></tt>";
					format-alt = "{:%d/%m}";
					interval = 1;
				};
			};
		};
	};
}
