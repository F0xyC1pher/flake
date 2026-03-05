{ stdenv, config, pkgs, lib, inputs, vars, ... }:
{
	let
		n = vars.nvidia;
		nvidiaOpts = if n then {
			extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
			blacklistedKernelModules = [ "nouveau" ];
			initrd.kernelModules = [ "nvidia" ];
		} else {};
	in
	boot = {
#	==========	KERNEL	==========
		kernelPackages = pkgs.linuxPackages_xanmod_latest;
#	==========	NVIDIA	==========
		extraModulePackages = nvidiaOpts.extraModulePackages or [];
		blacklistedKernelModules = nvidiaOpts.blacklistedKernelModules or [];
		initrd.kernelModules = nvidiaOpts.initrd.kernelModules or [];
#	==========	BOOTLOADER	==========
		loader.grub = {
			enable = true;
			device = "/dev/sda";
		};
		# loader.limine.enable = true;
		# boot.loader.limine.biosDevice = "/dev/disk/by-uuid/D793-503B"
	};
}
