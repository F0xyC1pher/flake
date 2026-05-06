{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: {
			xdg.configFile."waybar/modules/custom/notification.json".text = ''
				// syntax: json
				{
					"custom/notification": {
						"tooltip": false,
						"format": "{icon}",
						"format-icons": {
							"notification": "<span foreground='red'><sup></sup></span>",
							"none": "",
							"dnd-notification": "<span foreground='red'><sup></sup></span>",
							"dnd-none": "",
							"inhibited-notification": "<span foreground='red'><sup></sup></span>",
							"inhibited-none": "",
							"dnd-inhibited-notification": "<span foreground='red'><sup></sup></span>",
							"dnd-inhibited-none": "",
						},
						"return-type": "json",
						"exec-if": "which swaync-client",
						"exec": "swaync-client -swb",
						"on-click": "sleep 0.1s && swaync-client -t -sw",
						"on-click-right": "swaync-client -d -sw",
						"escape": true,
					},
				}
			'';
		};
	};
}
