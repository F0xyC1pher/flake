{...}: {
	imports = [
		./etc.nix
		./locale.nix
		./mime.nix
		./network.nix
		./nix-init.nix
		./nix.nix
		./security.nix
		./sops.nix
		# ./systemd.nix
		./variables.nix
		./xdg.nix
	];

	system.stateVersion = "26.05";
}
