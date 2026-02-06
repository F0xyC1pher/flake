{
	config,
	pkgs,
	inputs,
	...
}: {
	imports = [
		./bluetooth.nix
		./nvidia.nix
		./zram.nix
		# ./development
		# ./gaming
	];
}
