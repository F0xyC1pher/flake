{vars, ...}: {
	imports =
		[
			./video
			./boot
			./bluetooth.nix
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
