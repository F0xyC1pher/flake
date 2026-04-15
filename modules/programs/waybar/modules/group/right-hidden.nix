{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			xdg.configFile."waybar/modules/group/right-hidden.json".text = ''
				// syntax: json
				{
					"group/right-hidden": {
						"orientation": "horizontal",
						"drawer": {
							"transition-duration": 500,
							"transition-left-to-right": false,
							"click-to-reveal": true,
						},
						"modules": [
							"custom/arrow-left",
							"battery",
							"memory",
							"cpu",
							"disk",
							"network",
						],
					},
				}
			'';
		};
	};
}
