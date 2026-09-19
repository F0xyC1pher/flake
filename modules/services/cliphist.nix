{vars, ...}: {
	home-manager = {
		extraSpecialArgs = {inherit vars;};
		users.${vars.user.name} = {...}: {
			services.cliphist = {
				enable = true;

				# A Wayland session
				systemdTargets = ["graphical-session.target"];
				allowImages = true;
			};
		};
	};
}
