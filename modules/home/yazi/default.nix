{ lib, config, pkgs, inputs, vars, ... }:
{
	home-manager = {
		extraSpecialArgs = { inherit inputs vars; };
		users.${vars.userName} =  { config, pkgs, lib, ... }: {
			programs.yazi = {
				enableFishIntegration = true;
				enableBashIntegration = true;	
				enable = true;	
			};
		};
	};
}
