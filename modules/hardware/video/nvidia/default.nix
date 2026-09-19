{
	vars,
	pkgs,
	config,
	...
}: let
	nvidiaPkg = config.boot.kernelPackages.nvidiaPackages.${vars.host.hardware.video.driver.nvidia.package};
in {
	boot = {
		extraModulePackages = [nvidiaPkg];
		blacklistedKernelModules = ["nouveau"];
		initrd.kernelModules = ["nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm"];
	};

	services.xserver.videoDrivers = ["nvidia"];

	hardware = {
		graphics = {
			enable = true;
			enable32Bit = true;
			extraPackages = with pkgs; [
				nvidia-vaapi-driver
				nv-codec-headers-12
			];
		};
		nvidia = {
			package = nvidiaPkg;
			powerManagement.enable = false;
			powerManagement.finegrained = false;
			modesetting.enable = true;
			nvidiaSettings = true;
			open = vars.host.hardware.video.driver.nvidia.open;
		};
	};

	imports = [
		./application-profiles.nix
		./persistence-mode-max-perf.nix
	];
}
