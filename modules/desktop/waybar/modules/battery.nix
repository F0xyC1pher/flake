{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: {
			xdg.configFile."waybar/modules/battery.json".text = ''
				// syntax: json
				{
					"battery": {
						"format": "{icon} {capacity}%",
						"format-alt": "{icon} {time}",
						"format-charging": "󰂅 {capacity}%",
						"format-icons": ["󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"],
						"states": {
							"critical": 15,
							"warning": 30,
						},
					},
				}
			'';
		};
	};
}
