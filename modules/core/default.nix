{...}: {
	imports = [
		./security
		./xdg
		./etc.nix
		./locale.nix
		./network.nix
		./nix-init.nix
		./nix.nix
		./ssh.nix
		# ./systemd.nix
		./time.nix
		./tty.nix
		./variables.nix
	];

	system.stateVersion = "26.05";
}
