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

				# A Wayland session
				systemdTargets = ["graphical-session.target"];

				clipboardType = "both";
			};
		};
	};
}
