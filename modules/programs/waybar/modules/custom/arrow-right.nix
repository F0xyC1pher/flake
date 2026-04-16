{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			xdg.configFile."waybar/modules/custom/arrow-right.json".text = ''
				# json
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
