{
	config,
	pkgs,
	lib,
	inputs,
	vars,
	...
}: {
	imports = [
		./hyprland
		./mango
		./micro
		./niri
		# ./waybar
		./yazi
		./firefox.nix
		./home.nix
	];
	
	programs = {
		micro.enable = true;
	};
}
