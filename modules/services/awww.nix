{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {pkgs, ...}: {
			services.awww = {
				enable = true;
				package = pkgs.awww;
				extraArgs = [
					"--layer"
					"background"
				];
			};
		};
	};
}
