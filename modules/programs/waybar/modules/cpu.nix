{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			xdg.configFile."waybar/modules/cpu.json".text = ''
				// syntax: json
				{
					"cpu": {
						"interval": 2,
						"format": "{load:.0f}% ",
						"on-click": "kitty btop",
						"on-click-right": "kitty btop",
					},
				}
			'';
		};
	};
}
