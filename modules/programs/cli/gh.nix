{vars, ...}: {
	home-manager = {
		extraSpecialArgs = {inherit vars;};
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
