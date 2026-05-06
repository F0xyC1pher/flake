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

				recent-windows {
				    // off
				    // debounce-ms 0
				    // open-delay-ms 0

				    highlight {
				        // active-color "#99ff99ff"

				        // urgent-color "#9999ff"
				        // urgent-color "#9b0000"
				        // urgent-color "#ac4242"

				        // padding 0
				        // padding 10
				        // padding 100

				        corner-radius 0
				        // corner-radius 8
				        // corner-radius 30
				    }

				    previews {
				        // max-height 200
				        max-height 320
				        // max-height 1080
				        // max-height 10000

				        // max-scale 0.75
				        // max-scale 1
				    }

				    /-binds {
				        Mod+Tab         { next-window scope="output"; }
				        Mod+Shift+Tab   { previous-window scope="output"; }
				        Mod+grave       { next-window filter="app-id" scope="output"; }
				        Mod+Shift+grave { previous-window filter="app-id" scope="output"; }
				    }
				}


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
				        // off
				        // bottom-left
				        // top-right
				    }
				}

				// screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"
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
