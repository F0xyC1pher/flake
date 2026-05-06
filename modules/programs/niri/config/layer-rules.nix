{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: {
			xdg.configFile."niri/layer-rules.kdl".text = ''
				// syntax: kdl
				// ────────────── Layer Settings ──────────────
				layer-rule {
					match at-startup=true
					match namespace="waybar"
					match namespace="^slapper$"
					match namespace="^mpvpaper$"
					match namespace="^awww-daemon$"
					match namespace="^swww-daemonoverview$"
					match namespace="^noctalia-overview*"
					match namespace="^quickshell$"
					match namespace="dms:blurwallpaper"
					match namespace="^wallpaper$"
					place-within-backdrop true
				}
				layer-rule {
					match namespace="rofi"
					match namespace="fuzzel"
					match namespace="waybar"
					match namespace="noctalia-shell"

					shadow {
						on
						softness 40
						spread 10
						draw-behind-window true
					}

					place-within-backdrop true
				}
			'';
		};
	};
}
