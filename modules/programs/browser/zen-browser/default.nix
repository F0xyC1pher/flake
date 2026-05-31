{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: {
			programs.zen-browser = {
				enable = true;
				setAsDefaultBrowser = true;
			};
		};
	};
}
