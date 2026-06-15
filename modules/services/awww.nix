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
				package = inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww;
				extraArgs = [
					"--layer"
					"background"
				];
			};
		};
	};
}
