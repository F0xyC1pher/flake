{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: {
			programs.git = {
				enable = true;
				settings = {
					user = {
						name = "${vars.user.gitName}";
						email = "${vars.user.mail}";
					};
					init.defaultBranch = "master";
					pull.rebase = false;
				};
			};
		};
	};
}
