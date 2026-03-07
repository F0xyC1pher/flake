{
	config,
	pkgs,
	lib,
	inputs,
	vars,
	...
}: {
	imports = [
		./micro
		./niri
		./waybar
		./yazi
		./zarumet
		./firefox
		./home.nix
		./home-manager.nix
	];
}
