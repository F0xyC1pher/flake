{
	...
}:  {
	imports = [
		./hardware-configuration.nix
	];
	system.stateVersion = "26.05";
	hardware.cpu.intel.updateMicrocode = true;
	services.openssh.enable = true;
}
