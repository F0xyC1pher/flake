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

	home-manager = {
		extraSpecialArgs = { inherit inputs vars; };
		users.${vars.userName} = { ... }: {
			home.username = "${vars.userName}";
			home.homeDirectory = "/home/${vars.userName}";
			home.stateVersion = "26.05";
		};
	};
}
