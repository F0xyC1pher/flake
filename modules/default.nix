{
	config,
	pkgs,
	inputs,
	...
}: {
	imports = [
		./apps.nix
		./bluetooth.nix
		./configuration.nix
		./nvidia.nix
		./stylix.nix
		./xdg.nix
		./zram.nix
		# ./development
		# ./gaming
	];
}
