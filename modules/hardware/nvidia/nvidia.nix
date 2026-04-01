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
		config.boot.kernelPackages.nvidiaPackages.mkDriver {
			version = "580.142";
			sha256_64bit = "sha256-IJFfzz/+icNVDPk7YKBKKFRTFQ2S4kaOGRGkNiBEdWM=";
			sha256_aarch64 = "sha256-jntr88SpTYR648P1rizQjB/8KleBoa14Ay12vx8XETM=";
			openSha256 = "sha256-v968LbRqy8jB9+yHy9ceP2TDdgyqfDQ6P41NsCoM2AY=";
			settingsSha256 = "sha256-BnrIlj5AvXTfqg/qcBt2OS9bTDDZd3uhf5jqOtTMTQM=";
			persistencedSha256 = "sha256-il403KPFAnDbB+dITnBGljhpsUPjZwmLjGt8iPKuBqw=";
		};
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

			powerManagement.finegrained = false;
			powerManagement.enable = false;
			modesetting.enable = true;
			nvidiaSettings = true;
			open = false;
		};
	};
}
