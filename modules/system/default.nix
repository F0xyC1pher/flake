{...}: {
	imports = [
		./programs
		./services
		./systemd
		./bluetooth.nix
		./boot.nix
		./etc.nix
		./fonts.nix
		./locale.nix
		./mime.nix
		./network.nix
		./nix-init.nix
		./lix.nix
		./packages.nix
		./portal.nix
		./power.nix
		./security.nix
		./shells.nix
		./sops.nix
		./stylix.nix
		# ./swap.nix
		./users.nix
		./variables.nix
		./xdg.nix
		./zram.nix
		# ./zswap.nix
	];

	# systemd.user.services = import ./services/default.nix { inherit pkgs config lib inputs vars; };

	system.stateVersion = "26.05";
}
