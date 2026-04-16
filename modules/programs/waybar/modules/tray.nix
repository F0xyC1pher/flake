{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			xdg.configFile."waybar/modules/tray.json".text = ''
				# json
				{
					tray: {
						icon-size: 24,
						spacing: 10,
						show-passive-items = true;
					};
				}
			'';
		};
	};
}
