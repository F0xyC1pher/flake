{vars, ...}: {
	home-manager = {
		extraSpecialArgs = {inherit vars;};
		users.${vars.user.name} = {pkgs, ...}: {
			services.arrpc = {
				enable = true;
				package = pkgs.arrpc;
				systemdTarget = "graphical-session.target";
			};
		};
	};
}
