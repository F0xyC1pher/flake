{
	inputs,
	vars,
	...
}: {
	imports = [
		./initLua.nix
		./keymap.nix
		./plugins.nix
		./settings.nix
		./theme.nix
	];
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {pkgs, ...}: {
			programs.yazi = {
				enableFishIntegration = true;
				enableBashIntegration = true;
				package = pkgs.yazi.override {_7zz = pkgs._7zz-rar;};
				enable = true;
			};
		};
	};
}
