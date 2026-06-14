{...}: {
	imports = [
		./hardware-configuration.nix
	];
	system.stateVersion = "26.11";
	hardware.cpu.intel.updateMicrocode = true;
}
