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
		./niri
		# ./waybar
		./yazi
		./firefox.nix
		./home.nix
	];
}
