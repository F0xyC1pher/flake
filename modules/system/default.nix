{
	config,
	pkgs,
	lib,
	inputs,
	vars,
	...
}: {
	imports = [
		./awww-daemon.nix
		./awww-restore.nix
		./bluetooth.nix
		./boot.nix
		./configuration.nix
		./fonts.nix
		./locale.nix
		./mime.nix
		./network.nix
		./nvidia.nix
		./nvidia-persistence.nix
		./programs.nix
		./packages-custom.nix
		./packages.nix
		./portal.nix
		./rofi-polkit.nix
		./redist.nix
		./stylix.nix
		./services.nix
		./security.nix
		./users.nix
		./variables.nix
		./xdg.nix
		./zram.nix
	];

}
