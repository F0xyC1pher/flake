{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			xdg.configFile."niri/layer-rules.kdl".text = ''
				// syntax: kdl
				// ────────────── Layer Settings ──────────────
				layer-rule {
				    // This is for gslapper; change for other wallpaper tools.
				    // Find the right namespace by running niri msg layers.
				    match namespace="^slapper$"
				    place-within-backdrop true
				}
				layer-rule {
				    // This is for mpvpaper; change for other wallpaper tools.
				    // Find the right namespace by running niri msg layers.
				    match namespace="^mpvpaper$"
				    place-within-backdrop true
				}
				layer-rule {
					// This is for awww; change for other wallpaper tools.
					// Find the right namespace by running niri msg layers.
				    match namespace="^awww-daemon$"
				    place-within-backdrop true
				}
				layer-rule {
				    match namespace="^quickshell$"
				    place-within-backdrop true
				}
				layer-rule {
				    match namespace="dms:blurwallpaper"
				    place-within-backdrop true
				}

			'';
		};
	};
}
