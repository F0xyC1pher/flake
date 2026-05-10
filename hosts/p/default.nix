{
	...
}:  {
	imports = [
		./hardware-configuration.nix
		# ./tailscale.nix
		# ./zerotierone.nix
	];

	hardware.cpu.intel.updateMicrocode = true;
	services.openssh.enable = true;
}
