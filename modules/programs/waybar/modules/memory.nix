{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			xdg.configFile."waybar/modules/memory.json".text = ''
				// syntax: json
				{
					"memory": {
						"interval": 2,
						"format": "{}% 󰍛",
						"on-click": "kitty btop",
						"on-click-right": "cliphist-fuzzel-img",
					},
				}
			'';
		};
	};
}
