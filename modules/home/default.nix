{
	config,
	pkgs,
	lib,
	inputs,
	vars,
	...
}: {
	imports = [
		./home.nix
		./waybar
		./niri
		./firefox.nix
	];
}
