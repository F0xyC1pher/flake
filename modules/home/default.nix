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
		./firefox
		./home.nix
		./ssh.nix
		./vscodium
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
