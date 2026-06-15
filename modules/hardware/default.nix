{vars, ...}: {
	imports =
		[
			./nvidia
			./bluetooth.nix
			./boot.nix
			./power.nix
			./redist.nix
			./ssd.nix
			./swap.nix
		]
		++ (
			if vars.hardware.parallels.enable
			then [./parallels.nix]
			else []
		);
}
