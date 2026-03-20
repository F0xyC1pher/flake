{ lib, config, pkgs, inputs, vars, ... }:
{
  imports = [
    ./initLua.nix
    ./keymap.nix
    ./plugins.nix
    ./settings.nix
  ];
  
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
