{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {pkgs, ...}: {
			services.arrpc = {
				enable = true;
				package = pkgs.arrpc;
				systemdTarget = "graphical-session.target";
			};
		};
	};
}
