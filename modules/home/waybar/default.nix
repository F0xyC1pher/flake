{
	config,
	pkgs,
	lib,
	inputs,
	vars,
	...
}:
let
	waybarConfig = builtins.fromJSON (builtins.readFile ./config.json);
	waybarCss    = builtins.readFile ./style.css;
in
{
	# imports = [
	# 	./config.nix
	# 	./style.nix
	# ];
	home-manager = {	
		extraSpecialArgs = { inherit inputs vars; };
		
		users.${vars.userName} =  { config, pkgs, lib, ... }: {
			programs.waybar = {
				enable = true;
				systemd.enable = true;

				settings = [ waybarConfig ];
				style = waybarCss;
			};
			# systemd.user.services.waybar = {
			# 	Unit = {
			# 		After = [ "niri.service" ];
			# 		PartOf = [ "niri.service" ];
			# 		Target = "niri.service";
			# 	};
			# };
		};
	};
}
