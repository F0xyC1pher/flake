{
	inputs,
	vars,
	pkgs,
	...
}: {
	imports = [
		# ./${vars.shell}
		./bash
		./fish
		./zsh
	];
	environment.shells = with pkgs; [
		#vars.shell
		fish
		zsh
		bash
	];
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: {
			home.shell.enableShellIntegration = true;
		};
	};
}
