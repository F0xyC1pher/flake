{
	config,
	pkgs,
	lib,
	inputs,
	vars,
	...
}: {
	imports = [
		./environment
		./theming
		./hardware
		./xdg
		./configuration.nix
		# ./development
		# ./gaming
	];
	
	home-manager = {
		extraSpecialArgs = { inherit inputs vars; };
		users.${vars.userName} = { ... }: {
			imports = [
				./home
			];
		home.username = "${vars.userName}";
		home.homeDirectory = "/home/${vars.userName}";
		home.stateVersion = "25.05";
		};
	};
}
