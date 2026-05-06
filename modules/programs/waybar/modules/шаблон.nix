{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: {
			xdg.configFile."waybar/modules/module.json".text = ''
				// syntax: json
				{
					"some-text-variable":"some-value",
					"some-digit-variable": 0,
					"some-array-variable": [
						"1",
						"2",
						"3",
					],
				}
			'';
		};
	};
}
