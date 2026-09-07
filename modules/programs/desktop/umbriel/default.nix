{
	inputs,
	vars,
	...
}: {
	imports = [
		./config/appearance.nix
		./config/input-general.nix
		./config/keybinds.nix
		./config/window-rules.nix
	];
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {lib, ...}: {
			programs.umbriel.enable = true;
		};
	};
}
