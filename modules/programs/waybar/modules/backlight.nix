{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: {
			xdg.configFile."waybar/modules/backlight.json".text = ''
				// syntax: json
				{
					"backlight": {
						"device": "intel_backlight",
						"format": "{icon} {percent}%",
						"format-icons": [" ", " "],
					},
				}
			'';
		};
	};
}
