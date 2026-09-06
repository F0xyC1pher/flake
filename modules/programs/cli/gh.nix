{
	inputs,
	pkgs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: {
			programs.gh = {
				enable = true;
				gitCredentialHelper = {
					enable = true;
				};
			};
		};
	};
}
