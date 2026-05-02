{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			programs.git = {
				enable = true;
				settings = {
					user = {
						name = "Foxy_Chipher";
						email = "ageev-eldar@mail.ru";
					};
					init.defaultBranch = "master";
					# pull.rebase = true;
				};
			};
		};
	};
}
