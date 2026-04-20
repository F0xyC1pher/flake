{...}: {
	imports = [
		./boot.nix
		./etc.nix
		./fonts.nix
		./locale.nix
		./mime.nix
		./network.nix
		./nix-init.nix
		./nix.nix
		./packages.nix
		# ./portal.nix
		./power.nix
		./security.nix
		./sops.nix
		./stylix.nix
		./systemd.nix
		./users.nix
		./variables.nix
		./xdg.nix
	];

	# systemd.user.services = import ./services/default.nix { inherit pkgs config lib inputs vars; };

	system.stateVersion = "26.05";
}
