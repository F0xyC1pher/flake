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
						name = "FoxyChipher";
						email = "ageev-eldar@mail.ru";
					};
					init.defaultBranch = "master";
					# pull.rebase = true;
				};
			};
		};
	};
}
