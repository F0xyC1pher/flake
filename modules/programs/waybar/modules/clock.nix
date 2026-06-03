{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: {
			xdg.configFile."waybar/modules/clock.json".text = ''
				// syntax: json
				{
					"clock":{
						"interval": 1,
						"locale": "ru_RU.UTF-8",
						"format": "{:%H:%M:%S}",
						"format-alt": "{:%A, %b %d} ",
						"tooltip-format": "<tt><small>{calendar}</small></tt>",
						"calendar": {
							"mode": "year",
							"mode-mon-col": 3,
							"weeks-pos": "right",
							"format": {
								"months": "<span color='${vars.theme.style.text.sub-main}'><b>{}</b></span>",
								"days": "<span color='${vars.theme.style.text.main}'><b>{}</b></span>",
								"weekdays": "<span color='${vars.theme.colors.accent."6"}'><b>{}</b></span>",
								"today": "<span color='${vars.theme.style.accent}'><b><u>{}</u></b></span>",
							},
						},
					},
				}
			'';
		};
	};
}
