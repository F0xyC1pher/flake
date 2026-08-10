{
	lib,
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
					match namespace="^waybar$"
					match namespace="^launcher$"
					match namespace="^wallpaper$"
					match namespace="^slapper$"
					match namespace="^mpvpaper$"
					match namespace="^awww-daemon$"
					match namespace="^swww-daemonoverview$"
					match namespace="^noctalia-overview*"
					match namespace="^quickshell$"
					match namespace="dms:blurwallpaper"
					place-within-backdrop true
				}
				layer-rule {
					match namespace="^launcher$"
					match namespace="^waybar$"
					shadow {
						on
						color "#f6969676"
						softness 16
						spread 1
						draw-behind-window false
					}
				}
				${
					lib.optionalString (vars.theme.blur.enable && !vars.theme.blur.xray.enable) ''
						layer-rule {
							match namespace="^launcher$"
							match namespace="^waybar$"
							background-effect {
								blur true
								xray false
								liquid-glass {
									refraction-strength 1
									power-factor 1
									refraction-power 1
									glow-weight 0
									edge-lighting 1
									saturation 1.1
									vibrancy 1.666
									adaptive-dim 0
									adaptive-boost 0
									physical-refraction 1
									lens-distortion 1
									fringing 1
								}
							}
						}
					''
				}
			'';
		};
	};
}
