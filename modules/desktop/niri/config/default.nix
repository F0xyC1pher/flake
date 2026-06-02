{
	lib,
	vars,
	inputs,
	...
}: {
	imports =
		[
			./alt-tab.nix
			./animations.nix
			./binds.nix
			./colors.nix
			./cursor.nix
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
				include "alt-tab.kdl"
				include "animations.kdl"
				${lib.optionalString vars.theme.blur.enable ''include "blur.kdl"''}
				include "binds.kdl"
				include "colors.kdl"
				include "cursor.kdl"
				include "debug.kdl"
				include "input.kdl"
				include "layer-rules.kdl"
				include "layout.kdl"
				include "misc.kdl"
				include "outputs.kdl"
				include "window-rules.kdl"
			'';
		};
	};
}
