{
	lib,
	pkgs,
	inputs,
	...
}: {
	imports = [
		# ../../common/cpu/amd
		# ../../common/cpu/amd/raphael/igpu.nix
		# ../../common/cpu/amd/pstate.nix
		# ../../common/gpu/nvidia
		# ../../common/gpu/nvidia/prime.nix
		# ../../common/hidpi.nix
		# ../../common/pc/laptop
		# ../../common/pc/ssd
		# ./battery.nix

		inputs.nixos-hardware.nixosModules.common-cpu-amd
		# inputs.nixos-hardware.nixosModules.common-cpu-amd-raphael-igpu
		inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
		# inputs.nixos-hardware.nixosModules.common-gpu-nvidia
		inputs.nixos-hardware.nixosModules.common-hidpi
		inputs.nixos-hardware.nixosModules.common-pc-laptop
		inputs.nixos-hardware.nixosModules.common-pc-ssd
		./battery.nix
	];

	boot.kernelPackages = lib.mkForce pkgs.linuxPackages_latest;
	boot.kernelModules = ["asus_armoury"];

	services.power-profiles-daemon.enable = lib.mkDefault true;

	# Adds the missing asus functionality to Linux.
	# https://asus-linux.org/manual/asusctl-manual/
	services.asusd.enable = lib.mkDefault true;
}
