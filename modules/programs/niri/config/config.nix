{
	inputs,
	vars,
	lib,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			xdg.configFile."niri/config.kdl".text = ''
				include "animations.kdl"
				include "binds.kdl"
				include "colors.kdl"
				include "debug.kdl"
				include "input.kdl"
				include "layer-rules.kdl"
				include "layout.kdl"
				include "misc.kdl"
				include "outputs.kdl"
				include "window-rules.kdl"
				    ${lib.optionalString vars.blur.enable ''include "blur.kdl"''}
			'';
		};
	};
}
