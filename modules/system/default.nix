{
	#   config,
	#   pkgs,
	#   lib,
	#   inputs,
	#   vars,
	...
}: {
	imports = [
		# ./hardware
		./nix
		./services
		./bluetooth.nix
		./boot.nix
		./dropbox.nix
		./fonts.nix
		./locale.nix
		./mime.nix
		./network.nix
		./programs.nix
		./packages.nix
		./portal.nix
		./openssh.nix
		./security.nix
		./services.nix
		./sops.nix
		./stylix.nix
		./swap.nix
		./users.nix
		./variables.nix
		./xdg.nix
		./zram.nix
	];

	# systemd.user.services = import ./services/default.nix { inherit pkgs config lib inputs vars; };

	system.stateVersion = "26.05";
}
