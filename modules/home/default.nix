{
	config,
	pkgs,
	lib,
	inputs,
	vars,
	...
}: {
	imports = [
		# ./hyprland
		# ./mango
		./micro
		./niri
		# ./waybar
		./yazi
		./zarumet
		./firefox.nix
		./home.nix
	];
	
	programs = {
		micro.enable = true;
	};
}
