{...}: {
	imports = [
		./etc.nix
		./fonts.nix
		./locale.nix
		./mime.nix
		./network.nix
		./nix-init.nix
		./nix.nix
		./power.nix
		./security.nix
		./sops.nix
		./stylix.nix
		./systemd.nix
		./users.nix
		./variables.nix
		./xdg.nix
	];

	system.stateVersion = "26.05";
}
