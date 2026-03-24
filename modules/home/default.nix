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
    ./fuzzel
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
