{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: {
			xdg.configFile."waybar/modules/wireplumber.json".text = ''
				// syntax: json
				{
					"wireplumber": {
						"format": "{icon} {volume}%",
						"format-icons.default": ["󰕿", "󰖀", "󰕾"],
						"format-muted" : "󰝟 mute",
						"on-click" : "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle",
						"on-click-right" : "pavucontrol",
						"scroll-step" : 5,
						"max-volume" : 100.0,
					},

					"wireplumber#source": {
						"node-type" : "Audio/Source",
						"format" : "󰍬 {volume}%",
						"format-muted" : "󰍭 mute",
						"on-click" : "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle",
						"on-click-right" : "pavucontrol",
						"scroll-step": 5,
					},
				}
			'';
		};
	};
}
