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
		./firefox.nix
		./home.nix
		./home-manager.nix
		./nvidia-persistence.nix
	];
}
