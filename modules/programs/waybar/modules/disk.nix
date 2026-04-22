{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			xdg.configFile."waybar/modules/disk.json".text = ''
				// syntax: json
				{
					"disk": {
					  "interval": 60,
					  "path": "/",
					  "format": "{percentage_used}% ",
					  "on-click": "kitty yazi",
					  "tooltip-format": "{used} used out of {total} on {path} ({percentage_used}%)"
					},
				}
			'';
		};
	};
}
