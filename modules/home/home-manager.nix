{ lib, config, pkgs, inputs, vars, ... }:
{
	home-manager = {
		extraSpecialArgs = { inherit inputs vars; };
		users.${vars.userName} = { ... }: {
			# imports = [
			# ];
		home.username = "${vars.userName}";
		home.homeDirectory = "/home/${vars.userName}";
		home.stateVersion = "25.05";
		};
	};
}
