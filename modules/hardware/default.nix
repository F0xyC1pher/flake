{...}: {
	imports = [
		./boot
		./nvidia
		./swap
		./bluetooth.nix
		./parallels.nix
		./power.nix
		./redist.nix
		./ssd.nix
	];
}
