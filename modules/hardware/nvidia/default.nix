{
	vars,
	config,
	...
}: let
	ne = vars.hardware.nvidia.enable;
	nvidiaPkg = config.boot.kernelPackages.nvidiaPackages.${vars.hardware.nvidia.package};
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

	services.xserver.videoDrivers = ["nvidia"];

	hardware = {
		graphics = {
			enable = true;
			enable32Bit = true;
		};
		nvidia = {
			package = nvidiaPkg;

			# Disable dynamic dynamic power off for low-latency desktop/gaming performance
			powerManagement.enable = false;
			powerManagement.finegrained = false;

			modesetting.enable = true;
			nvidiaSettings = true;
			open = false;
		};
	};

	imports = [
		./application-profiles.nix
		./persistence-mode-max-perf.nix
	];
}
