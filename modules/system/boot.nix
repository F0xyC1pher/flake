{ stdenv, config, pkgs, lib, inputs, vars, ... }:
	let
		n = vars.nvidia;
		nO = if n then {
			eMP = [ config.boot.kernelPackages.nvidia_x11 ];
			bKM = [ "nouveau" ];
			iKM = [ "nvidia" ];
		} else {};
	in
{
	boot = {
#	==========	KERNEL	==========
		kernelPackages = pkgs.linuxPackages_xanmod_latest;
#	==========	NVIDIA	==========
		extraModulePackages = nO.eMP or [];
		blacklistedKernelModules = nO.bKM or [];
		initrd.kernelModules = nO.iKM or [];
#	==========	BOOTLOADER	==========
		loader.grub = {
			enable = true;
			device = "/dev/sda";
		};
		# loader.limine.enable = true;
		# boot.loader.limine.biosDevice = "/dev/disk/by-uuid/D793-503B"
	};
}
