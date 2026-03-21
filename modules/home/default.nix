{
	config,
	pkgs,
	lib,
	inputs,
	vars,
	...
}: {
	imports = [
		./firefox
		./micro
		./niri
		./rofi
		./vscodium
		./waybar
		./yazi
		./home.nix
		#./ssh.nix
	];
}
