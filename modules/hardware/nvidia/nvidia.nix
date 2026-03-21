{ config, pkgs, lib, inputs, vars, ... }:
{
	# ========== NVIDIA ==========
	services.xserver.videoDrivers = ["nvidia"];
	hardware = {
		graphics = {
			enable = true;
			enable32Bit = true;
		};
		nvidia = {
			package = config.boot.kernelPackages.nvidiaPackages.stable;
			powerManagement.finegrained = false;
			powerManagement.enable = false;
			modesetting.enable = true;
			nvidiaSettings = true;
			open = false;
		};
	};
}





