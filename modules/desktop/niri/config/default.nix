{
	lib,
	vars,
	inputs,
	...
}: {
	imports =
		[
			./animations.nix
			./binds.nix
			./colors.nix
			./debug.nix
			./input.nix
			./layer-rules.nix
			./layout.nix
			./misc.nix
			./outputs.nix
			./window-rules.nix
		]
		++ lib.optionals vars.theme.blur.enable [./blur.nix];
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: {
			xdg.configFile."niri/config.kdl".text = ''
				// syntax: kdl
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
				    ${lib.optionalString vars.theme.blur.enable ''include "blur.kdl"''}
			'';
		};
	};
}
