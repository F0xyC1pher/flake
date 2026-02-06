{
	config,
	pkgs,
	inputs,
	...
}: {
	imports = [
		./environment
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
