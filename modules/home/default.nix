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
	];

	home-manager = {
		extraSpecialArgs = { inherit inputs vars; };
		users.${vars.userName} = { ... }: {
			home.username = "${vars.userName}";
			home.homeDirectory = "/home/${vars.userName}";
			home.stateVersion = "25.05";
		};
	};
}
