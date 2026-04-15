{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			xdg.configFile."waybar/modules/group/left-hidden.json".text = ''
				# json
				{
					"group/left-hidden" = {
						"orientation" = "horizontal";
						"drawer" = {
							"transition-duration" = 500;
							"transition-left-to-right" = true;
							"click-to-reveal" = true;
						};
						"modules" = [
							"custom/arrow-right"
							"backlight"
							"bluetooth"
							"wireplumber"
							"wireplumber#source"
						];
					};
				}
			'';
		};
	};
}
