{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			xdg.configFile."waybar/modules/niri.json".text = ''
				// syntax: json
				{
					"niri/workspaces": {
						"on-click": "activate",
						"current-only": false,
						"format": "{icon}",
						"format-icons": {
							"1": "一",
							"2": "二",
							"3": "三",
							"4": "四",
							"5": "五",
							"6": "六",
							"7":"七",
							"8": "八",
							"9": "九",
							"10": "十",
							"11": "一",
						},
					},

					"niri/language": {
						"format": "язык: {}",
						"format-en": "🇺🇸 EN",
						"format-ru": "🇷🇺 RU",
						"interval": 1,
					},
				}
			'';
		};
	};
}
