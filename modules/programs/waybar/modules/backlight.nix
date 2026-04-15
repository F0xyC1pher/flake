{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			xdg.configFile."waybar/modules/backlight.json".text = ''
				# json
				{
					backlight = {
						device = "intel_backlight";
						format = "{icon} {percent}%";
						format-icons = [" " " "];
					};
				}
			'';
		};
	};
}
