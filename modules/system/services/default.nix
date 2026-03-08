{
	config,
	pkgs,
	lib,
	inputs,
	vars,
	...
}:
{
	imports = [
		./awww-daemon-s.nix
		./awww-restore-s.nix
		./rofi-polkit-s.nix
		./swaync-s.nix
		./waybar-s.nix
	];
}
