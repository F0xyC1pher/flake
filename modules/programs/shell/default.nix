{
	inputs,
	vars,
	pkgs,
	...
}: {
	imports = [
		./${vars.shell}
	];
	environment.shells = [
		pkgs.${vars.shell}
	];
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			home.shell.enableShellIntegration = true;
		};
	};
}
