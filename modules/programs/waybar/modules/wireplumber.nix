{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			xdg.configFile."waybar/modules/wireplumber.json".text = ''
				# json
				{
					wireplumber = {
						format = "{icon} {volume}%";
						format-icons.default = ["󰕿" "󰖀" "󰕾"];
						format-muted = "󰝟 mute";
						on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
						scroll-step = 2.5;
						max-volume = 100.0;
					};

					"wireplumber#source" = {
						"node-type" = "Audio/Source";
						format = "󰍬 {volume}%";
						format-muted = "󰍭 mute";
						"on-click-right" = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
						scroll-step = 2.5;
					};
				}
			'';
		};
	};
}
