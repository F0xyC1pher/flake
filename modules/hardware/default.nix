{vars,...}: {
	imports = [
		./boot
		./nvidia
		./swap
		./bluetooth.nix
		./power.nix
		./redist.nix
		./ssd.nix
	]++(
	if vars.hardware.parallels.enable
	then 
		[./parallels.nix] 
	else
		[]
	);
}
