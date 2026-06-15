{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: {
			xdg.configFile."niri/misc.kdl".text = ''
				// syntax: kdl
				// ────────────── Overview Settings ──────────────
				// Optionally, disable the workspace shadows in the overview.
				overview {
					backdrop-color "#16161677"
					workspace-shadow {
						//    off
						softness 30
						spread 5
						offset x=0 y=0
						color "#ff000007"
					}
				}

				/-overview {
					// zoom 0.0001
					// zoom 0.01
					// zoom 0.1
					// zoom 0.25
					// zoom 0.5
					// zoom 0.333
					// zoom 0.75
					// backdrop-color "#ffffff"
					// backdrop-color "#444"
					// backdrop-color "#900"
					// backdrop-color "#262626"
					workspace-shadow {
						// off
						// softness 0
						// softness 40
						// softness 45
						// softness 50
						// softness 60
						// softness 80
						// softness 100
						// spread 5
						// spread 10
						// spread 50
						// offset x=0 y=10
						// offset x=20 y=20
						// color "#0005"
						// color "#000d"
						// color "#000a"
					}
				}
				gestures {
					hot-corners {
						bottom-left
						bottom-right
					}
				}
				screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"
				// screenshot-path "~/Pictures/niri-scale/%M-%S.png"
				// screenshot-path "%M-%S.png"
				hotkey-overlay {
					skip-at-startup
				}
				clipboard {
					// disable-primary
				}
			'';
		};
	};
}
