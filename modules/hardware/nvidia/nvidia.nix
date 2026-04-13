{
	config,
	# pkgs,
	# lib,
	# inputs,
	vars,
	...
}: let
	ne = vars.hardware.nvidia.enable;
	nvidiaPkg =
		config.boot.kernelPackages.nvidiaPackages.legacy_580;
	nO =
		if ne
		then {
			eMP = [nvidiaPkg];
			bKM = ["nouveau"];
			iKM = ["nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm"];
		}
		else {};
in {
	boot = {
		extraModulePackages = nO.eMP or [];
		blacklistedKernelModules = nO.bKM or [];
		initrd.kernelModules = nO.iKM or [];
	};
	# ========== NVIDIA ==========
	services.xserver.videoDrivers = ["nvidia"];
	hardware = {
		graphics = {
			enable = true;
			enable32Bit = true;
		};
		nvidia = {
			# package = config.boot.kernelPackages.nvidiaPackages.stable;
			package = nvidiaPkg;

			powerManagement.enable = true;
			modesetting.enable = true;
			nvidiaSettings = true;
			open = false;
		};
	};
}
