{
	config,
	pkgs,
	inputs,
	...
}: {
	imports = [
		./bluetooth.nix
		./nvidia.nix
		./redist.nix
		./zram.nix
		# ./development
		# ./gaming
	];
}
