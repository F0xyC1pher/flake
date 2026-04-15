{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			xdg.configFile."waybar/modules/clock.json".text = ''
				# json
				{
					placeholder
				}
			'';
		};
	};
}
