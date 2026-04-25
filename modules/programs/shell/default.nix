{
	inputs,
	vars,
	pkgs,
	...
}: {
	imports = [
		./${vars.shell}
	];
	environment.shells = with pkgs; [
		#vars.shell
		fish
		zsh
		bash
	];
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			home.shell.enableShellIntegration = true;
		};
	};
}
