{inputs, ...}: {
	imports = [
		inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x230
		./hardware-configuration.nix
		# ./tailscale.nix
		# ./zerotierone.nix
	];

	hardware.cpu.intel.updateMicrocode = true;
	services.openssh.enable = true;
}
