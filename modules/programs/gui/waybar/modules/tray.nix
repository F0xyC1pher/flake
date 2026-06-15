{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: {
			xdg.configFile."waybar/modules/tray.json".text = ''
				// syntax: json
				{
					"tray": {
						"icon-size": 24,
						"spacing": 10,
						"show-passive-items": true,
					},
				}
			'';
		};
	};
}
