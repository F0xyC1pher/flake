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
				userName = "Foxy_Chipher";
				userEmail = "ageev-eldar@mail.ru";
				extraConfig = {
					init.defaultBranch = "master";
					# pull.rebase = true;
				};
			};
		};
	};
}
