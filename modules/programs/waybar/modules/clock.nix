{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
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
								"months": "<span color='${vars.style.theme.text.sub-main}'><b>{}</b></span>",
								"days": "<span color='${vars.style.theme.text.main}'><b>{}</b></span>",
								"weekdays": "<span color='${vars.style.colors.accent.yellow}'><b>{}</b></span>",
								"today": "<span color='${vars.style.theme.accent}'><b><u>{}</u></b></span>",
							},
						},
					},
				}
			'';
		};
	};
}
