{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			xdg.configFile."waybar/modules/cpu.json".text = ''
				# json
				{
					cpu = {
						interval = 2;
						format = "{load:.0f}% "; # целое число: 1% вместо 0.7% или 0.58%
						on-click = "kitty btop";
						on-click-right = "kitty btop";
					};
				}
			'';
		};
	};
}
