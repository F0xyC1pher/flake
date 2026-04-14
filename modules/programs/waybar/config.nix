{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			programs.waybar = {
				enable = true;
				# systemd.enable = false;
				# 	settings = [
				# 		{
				# 			height = 1;
				# 			layer = "top";
				# 			position = "top";

				# 			modules-left = ["backlight" "wireplumber" "wireplumber#source" "niri/language" "bluetooth"];
				# 			modules-center = ["niri/workspaces"];
				# 			modules-right = ["tray" "clock#time" "custom/clock" "battery"];

				# 			backlight = {
				# 				device = "intel_backlight";
				# 				format = "{icon} {percent}%";
				# 				format-icons = [" " " "];
				# 			};
				# 			bluetooth = {
				# 				format = "󰂯 {status}";
				# 				format-connected = "󰂯 {device_battery_percentage}%";
				# 				tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
				# 				tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
				# 				tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
				# 				tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
				# 			};
				# 			tray = {
				# 				icon-size = 18;
				# 				spacing = 12;
				# 				show-passive-items = true;
				# 			};
				# 			battery = {
				# 				format = "{icon} {capacity}%";
				# 				format-alt = "{icon} {time} ";
				# 				format-charging = "󰂅 {capacity}%";
				# 				format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
				# 				states = {
				# 					critical = 15;
				# 					warning = 30;
				# 				};
				# 			};
				# 			"clock#time" = {
				# 				format = "󰸘 {:%b %e}";
				# 				tooltip-format = "<tt>{calendar}</tt>";
				# 				interval = 1;
				# 			};
				# 			"custom/clock" = {
				# 				exec = "date +\" %H:%M:%S\"";
				# 				/*
				#   •
				#   */
				# 				interval = 1;
				# 			};
				# 			"niri/language" = {
				# 				format = "{}";
				# 				format-en = "🇺🇸 EN";
				# 				format-ru = "🇷🇺 RU";
				# 				interval = 1;
				# 			};
				# 			wireplumber = {
				# 				format = "{icon} {volume}%";
				# 				# format-icons = [ "" "" "" ];
				# 				format-icons = {
				# 					default = ["󰕿" "󰖀" "󰕾"];
				# 				};
				# 				format-muted = "󰝟 mute";
				# 				on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
				# 				scroll-step = 2.5;
				# 				max-volume = 100.0;
				# 			};
				# 			"wireplumber#source" = {
				# 				node-type = "Audio/Source";
				# 				format = "󰍬 {volume}%";
				# 				format-muted = "󰍭 mute";
				# 				on-click-right = "wpctl set-mute @default_audio_source@ toggle";
				# 				scroll-step = 2.5;
				# 			};
				# 			"niri/workspaces" = {
				# 				on-click = "activate";
				# 				current-only = false;
				# 				format = "{icon}";
				# 				format-icons = {
				# 					"1" = "一";
				# 					"2" = "二";
				# 					"3" = "三";
				# 					"4" = "四";
				# 					"5" = "五";
				# 					"6" = "六";
				# 					"7" = "七";
				# 					"8" = "八";
				# 					"9" = "九";
				# 					"10" = "十";
				# 					"11" = "一";
				# 				};
				# 				persistent-workspaces = {
				# 					"DVI-D-1" = ["1" "2" "3" "4" "5" "6" "7" "8" "9" "10"];
				# 				};
				# 			};
				# 		}
				# 	];
				settings = ''
					{
					  "layer": "top",
					  "position": "top",
					  "height": 56,
					  "spacing": 3,
					  "margin-bottom": -15,
					  "modules-left": [
					    "backlight",
					    "wireplumber",
					    "wireplumber#source",
					    "niri/language",
					    "bluetooth"
					  ],
					  "modules-center": [
					  	"niri/workspaces"
					  ],
					  "modules-right": [
					    "custom/notification",
					    "network",
					    "cpu",
					    "memory",
					    "clock",
					    "tray",
					    "battery"
					  ],

					  "backlight": {
					    "device": "intel_backlight",
					    "format": "{icon} {percent}%",
					    "format-icons": [" ", " "]
					  },

					  "wireplumber": {
					    "format": "{icon} {volume}%",
					    "format-icons": {
					      "default": ["󰕿", "󰖀", "󰕾"]
					    },
					    "format-muted": "󰝟 mute",
					    "on-click": "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle",
					    "scroll-step": 2.5,
					    "max-volume": 100.0
					  },

					  "wireplumber#source": {
					    "node-type": "Audio/Source",
					    "format": "󰍬 {volume}%",
					    "format-muted": "󰍭 mute",
					    "on-click-right": "wpctl set-mute @default_audio_source@ toggle",
					    "scroll-step": 2.5
					  },

					  "battery": {
					    "format": "{icon} {capacity}%",
					    "format-alt": "{icon} {time}",
					    "format-charging": "󰂅 {capacity}%",
					    "format-icons": ["󰁺","󰁻","󰁼","󰁽","󰁾","󰁿","󰂀","󰂁","󰂂","󰁹"],
					    "states": {
					      "critical": 15,
					      "warning": 30
					    }
					  },

					  "niri/workspaces": {
					    "on-click": "activate",
					    "current-only": false,
					    "format": "{icon}",
					    "format-icons": {
					      "1": "一",
					      "2": "二",
					      "3": "三",
					      "4": "四",
					      "5": "五",
					      "6": "六",
					      "7": "七",
					      "8": "八",
					      "9": "九",
					      "10": "十",
					      "11": "一"
					    },
					    "persistent-workspaces": {
					      "DVI-D-1": ["1","2","3","4","5","6","7","8","9","10"]
					    }
					  },

					  "niri/window": {
					    "format": "{}",
					    "rewrite": {
					      "(.*) - Mozilla Firefox": "🌎 $1",
					      "(.*) - zsh": "> [$1]"
					    }
					  },

					  "niri/language": {
					    "format": "Язык: {}",
					    "format-en": "🇺🇸 EN",
					    "format-ru": "🇷🇺 RU",
					    "interval": 1
					  },

					  "tray": {
					    "icon-size": 24,
					    "spacing": 10,
					    "show-passive-items": true
					  },

					  "custom/notification": {
					    "tooltip": false,
					    "format": "{icon}",
					    "format-icons": {
					      "notification": "<span foreground='red'><sup></sup></span>",
					      "none": "",
					      "dnd-notification": "<span foreground='red'><sup></sup></span>",
					      "dnd-none": "",
					      "inhibited-notification": "<span foreground='red'><sup></sup></span>",
					      "inhibited-none": "",
					      "dnd-inhibited-notification": "<span foreground='red'><sup></sup></span>",
					      "dnd-inhibited-none": ""
					    },
					    "return-type": "json",
					    "exec-if": "which swaync-client",
					    "exec": "swaync-client -swb",
					    "on-click": "sleep 0.1s && swaync-client -t -sw",
					    "on-click-right": "swaync-client -d -sw",
					    "escape": true
					  },

					  "clock": {
					    "interval": 1,
					    "format": "{:%H:%M:%S}",
					    "format-alt": "{:%A, %b %d} ",
					    "tooltip-format": "<tt><small>{calendar}</small></tt>",
					    "calendar": {
					      "mode": "year",
					      "mode-mon-col": 3,
					      "weeks-pos": "right",
					      "format": {
					        "months": "<span color='#ffead3'><b>{}</b></span>",
					        "days": "<span color='#ecc6d9'><b>{}</b></span>",
					        "weekdays": "<span color='#ffcc66'><b>{}</b></span>",
					        "today": "<span color='#ff6699'><b><u>{}</u></b></span>"
					      }
					    }
					  },

					  "cpu": {
					    "interval": 2,
					    "format": "{load}% ",
					    "on-click": "nwg-drawer -ovl",
					    "on-click-right": "gnome-system-monitor"
					  },

					  "memory": {
					    "interval": 2,
					    "format": "{}% 󰍛",
					    "on-click": "GDK_BACKEND=x11 nemo",
					    "on-click-right": "cliphist list | rofi -dmenu -normal-window | cliphist decode | wl-copy"
					  },

					  "disk": {
					    "interval": 30,
					    "path": "/",
					    "format": "{percentage_used}% ",
					    "on-click": "nemo",
					    "tooltip-format": "{used} used out of {total} on {path} ({percentage_used}%)"
					  },

					  "network": {
					    "interval": 2,
					    "format-wifi": "{essid} ({signalStrength}%)\uf1eb",
					    "format-ethernet": "󰈀  {ifname}",
					    "format-linked": "\uf059 No IP ({ifname})",
					    "format-disconnected": "\uf071 Disconnected",
					    "tooltip-format": "{ifname} {ipaddr}/{cidr} via {gwaddr}",
					    "format-alt": "\uf1eb↓{bandwidthDownBytes} ↑{bandwidthUpBytes}",
					    "on-click-right": "~/.config/maomao/scripts/networkmanager_dmenu"
					  }
					}

				'';
			};
		};
	};
}
