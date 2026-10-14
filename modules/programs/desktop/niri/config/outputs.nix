{vars, ...}: {
	home-manager = {
		extraSpecialArgs = {inherit vars;};
		users.${vars.user.name} = {...}: {
			xdg.configFile."niri/outputs.kdl".text = ''
				// syntax: kdl
				// ────────────── Output Configuration ──────────────
				// https://yalter.github.io/niri/Configuration:-Outputs
				output "${vars.host.hardware.video.output.name}" {
					mode "${vars.host.hardware.video.output.resolution}@${toString vars.host.hardware.video.output.framerate}"
					scale ${toString vars.host.hardware.video.output.scale}
					transform "normal"
					position x=0 y=0
					layout {
						main-axis "horizontal"
					}
				}
			'';
		};
	};
}
