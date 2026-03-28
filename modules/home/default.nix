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
    ./nixcord
		./rofi
		./vscodium
		./waybar
		./yazi
		./home.nix
		#./ssh.nix
	];
}
