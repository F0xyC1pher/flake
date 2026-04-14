{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			xdg.configFile."niri/outputs.kdl".text = ''
				// ────────────── Output Configuration ──────────────
				// https://yalter.github.io/niri/Configuration:-Outputs
				output "DVI-D-1" {
					mode "1920x1080@60.000"
				    scale 1
				    transform "normal"
				    position x=0 y=0
				}
			'';
		};
	};
}
