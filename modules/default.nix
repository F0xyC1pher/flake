{
	config,
	pkgs,
	inputs,
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
				./home.nix
			];
		};
	};
}
