{vars, ...}: {
	home-manager = {
		extraSpecialArgs = {inherit vars;};
		users.${vars.user.name} = {...}: {
			programs.wezterm = {
				enable = true;
			};
		};
	};
}
