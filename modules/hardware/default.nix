{...}: {
	imports = [
		./boot
		./nvidia
		./swap
		./bluetooth.nix
		./parallels.nix
		./redist.nix
		./ssd.nix
	];
}
