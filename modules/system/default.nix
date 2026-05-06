{...}: {
	imports = [
		./etc.nix
		./locale.nix
		./mime.nix
		./network.nix
		./nix-init.nix
		./nix.nix
		./portals.nix
		./security.nix
		./sops.nix
		# ./systemd.nix
		./terminal-exec.nix
		./variables.nix
	];

	system.stateVersion = "26.05";
}
