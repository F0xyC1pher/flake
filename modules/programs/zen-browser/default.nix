{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			programs.zen-browser = {
				enable = true;
				setAsDefaultBrowser = true;
			};
		};
	};
}
