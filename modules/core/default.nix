{...}: {
	imports = [
		./network
		./security
		./xdg
		./etc.nix
		./locale.nix
		./man.nix
		./nix.nix
		./nix-init.nix
		#./nix-ld.nix
		./nixpkgs.nix
		./ssh.nix
		# ./systemd.nix
		./time.nix
		./tty.nix
		./variables.nix
	];
}
