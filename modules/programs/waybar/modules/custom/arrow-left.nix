{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			xdg.configFile."waybar/modules/custom/arrow-left.json".text = ''
				# json
				{
					"custom/arrow-left" = {
						"format" = "";
						"tooltip" = false;
						"cursor" = true;
					};
				}
			'';
		};
	};
}
