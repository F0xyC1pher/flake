{
	# lib,
	# config,
	inputs,
	vars,
	...
}: {
	imports = [
		./initLua.nix
		./keymap.nix
		./plugins.nix
		./settings.nix
	];
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {
			# config,
			# lib,
			pkgs,
			...
		}: {
			programs.yazi = {
				enableFishIntegration = true;
				enableBashIntegration = true;
				package = pkgs.yazi.override {_7zz = pkgs._7zz-rar;};
				enable = true;
			};
		};
	};
}
