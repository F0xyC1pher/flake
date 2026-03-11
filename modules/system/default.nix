{
	config,
	pkgs,
	lib,
	inputs,
	vars,
	...
}: {
	imports = [
		./hardware
		./services
		# ./awww-daemon.nix
		# ./awww-restore.nix
		./bluetooth.nix
		./boot.nix
		./fonts.nix
		./locale.nix
		./mime.nix
		./network.nix
		./programs.nix
		./packages-custom.nix
		./packages.nix
		./portal.nix
		# ./rofi-polkit.nix
		./stylix.nix
		./services.nix
		./security.nix
		./users.nix
		./variables.nix
		./xdg.nix
		./zram.nix
	];

	# systemd.user.services = import ./services/default.nix { inherit pkgs config lib inputs vars; };

	system.stateVersion = "26.05";

}
