{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: {
			xdg.configFile."niri/alt-tab.kdl".text = ''
				// syntax: kdl
				recent-windows {
					// off
					// debounce-ms 0
					// open-delay-ms 0
					highlight {
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
				}
			'';
		};
	};
}
