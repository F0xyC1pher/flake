{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: {
			xdg.configFile."niri/outputs.kdl".text = ''
				// syntax: kdl
				// ────────────── Output Configuration ──────────────
				// https://yalter.github.io/niri/Configuration:-Outputs
				output "HDMI-A-1" {
					mode "1600x900@60.000"
					// scale 1
					// transform "normal"
					// position x=0 y=0
				}
			'';
		};
	};
}
