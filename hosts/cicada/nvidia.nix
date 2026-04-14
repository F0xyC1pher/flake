{config, ...}: {
	services.xserver.videoDrivers = ["nvidia"];
	boot = {
		extraModulePackages = [config.boot.kernelPackages.nvidiaPackages.latest];
		blacklistedKernelModules = ["nouveau"];
		initrd.kernelModules = ["nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm"];
	};
	hardware = {
		graphics = {
			enable32Bit = true;
			enable = true;
		};
		nvidia = {
			package = config.boot.kernelPackages.nvidiaPackages.latest;
			powerManagement.enable = true;
			modesetting.enable = true;
			nvidiaSettings = true;
			open = true;
		};
	};
}
