{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			xdg.configFile."zsh/.p10k.zsh".source = ./.pk10.zsh;
		};
	};
}
