{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {pkgs, ...}: {
			services.arrpc = {
				enable = true;
				package = pkgs.arrpc;
				systemdTarget = "graphical-session.target";
			};
		};
	};
}
