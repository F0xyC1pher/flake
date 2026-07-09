{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: {
			services.wl-clip-persist = {
				enable = true;
				systemdTargets = ["graphical-session.target"];
				clipboardType = "regular";
			};
		};
	};
}
