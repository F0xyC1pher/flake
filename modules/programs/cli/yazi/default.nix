{
	inputs,
	vars,
	...
}: {
	imports = [
		./plugins
		./initLua.nix
		./keymap.nix
		./settings.nix
		./theme.nix
	];
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {pkgs, ...}: {
			programs.yazi = {
				enable = true;
				enableFishIntegration = vars.hasProgram "fish";
				enableBashIntegration = vars.hasProgram "bash";
				package =
					pkgs.yazi.override {
						_7zz = pkgs._7zz-rar; # Support for RAR extraction
					};
			};
		};
	};
}
