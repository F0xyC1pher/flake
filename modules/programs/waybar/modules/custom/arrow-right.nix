{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: {
			xdg.configFile."waybar/modules/custom/arrow-right.json".text = ''
				// syntax: json
				{
					"custom/arrow-right": {
						"format": "",
						"tooltip": false,
						"cursor": true,
					},
				}
			'';
		};
	};
}
