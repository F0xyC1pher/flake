{
	inputs,
	vars,
	...
}: {
	programs.zsh.enable = true;
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			programs.zsh = {
				enable = true;
				enableCompletion = true;
				autosuggestion.enable = true;
				syntaxHighlighting.enable = true;
				history.size = 10000;
			};
		};
	};
}
