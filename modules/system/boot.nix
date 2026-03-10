{ stdenv, config, pkgs, lib, inputs, vars, ... }:
	let

	in
{
	boot = {
#	==========	KERNEL	==========
		kernelPackages = pkgs.linuxPackages_xanmod_latest;
#	==========	BOOTLOADER	==========
		loader = if vars.bootLoader == "GRUB" then {
			grub.enable = true;
			grub.device = config.fileSystems."/boot".device;
		} else if vars.bootLoader == "Limine" then {
			limine.enable = true;
			limine.biosDevice = config.fileSystems."/boot".device;
		} else throw "Unknown boot loader: ${vars.bootLoader}";
	};
}
