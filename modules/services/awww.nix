{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {pkgs, ...}: {
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
