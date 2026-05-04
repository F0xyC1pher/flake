{
	inputs,
	vars,
	...
}: {
	imports = [
		./extensions.nix
		./policies.nix
		./userChrome.nix
		./userContent.nix
		./userJS.nix
	];

	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			programs.firefox = {
				enable = true;
				profiles.${vars.userFullName} = {
					name = "${vars.userFullName}";
					isDefault = true;
					id = 0;
				};
			};
		};
	};
}
