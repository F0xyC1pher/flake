{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			services.cliphist = {
				enable = true;

				# A Wayland session
				systemdTargets = ["graphical-session.target"];
				allowImages = true;
			};
		};
	};
}
