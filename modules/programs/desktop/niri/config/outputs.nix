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
				output "${vars.hardware.video.output.name}" {
					mode "${vars.hardware.video.output.resolution}@${vars.hardware.video.output.framerate}"
					// scale 1
					// transform "normal"
					// position x=0 y=0
				}
			'';
		};
	};
}
