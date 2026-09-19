{vars, ...}: {
	imports = [
		./config/appearance.nix
		./config/input-general.nix
		./config/keybinds.nix
		./config/window-rules.nix
	];
	home-manager = {
		extraSpecialArgs = {inherit vars;};
		users.${vars.user.name} = {
			programs.umbriel.enable = true;
		};
	};
}
