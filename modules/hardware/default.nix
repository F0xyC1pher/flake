{...}: {
	imports = [
		./memory
		./nvidia
		./bluetooth.nix
		./boot.nix
		./parallels.nix
		./redist.nix
		./ssd.nix
	];
}
