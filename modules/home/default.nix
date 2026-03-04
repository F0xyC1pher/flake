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
		./waybar
		./yazi
		./zarumet
		./firefox.nix
		./home.nix
		./home-manager.nix
	];
}
