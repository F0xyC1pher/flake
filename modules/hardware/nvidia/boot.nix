{ stdenv, config, pkgs, lib, inputs, vars, ... }:
	let
		ne = vars.hardware.nvidia.enable;
		nO = if ne then {
			eMP = [ config.boot.kernelPackages.nvidia_x11 ];
			bKM = [ "nouveau" ];
			iKM = [ "nvidia" ];
		} else {};
	in
{
	boot = {
		extraModulePackages = nO.eMP or [];
		blacklistedKernelModules = nO.bKM or [];
		initrd.kernelModules = nO.iKM or [];
	};
}
