{
	pkgs,
	lib,
	vars,
	...
}: let
	gpuType = vars.hardware.video.driver.amd.type or "modern";
	isLegacy = gpuType == "legacy";
in {
	boot = {
		kernelParams =
			lib.optionals isLegacy [
				"radeon.si_support=0"
				"amdgpu.si_support=1"
				"radeon.cik_support=0"
				"amdgpu.cik_support=1"
			];
		initrd.kernelModules = ["amdgpu"];
		kernelModules = ["amdgpu"];
	};

	services.xserver.videoDrivers = ["amdgpu"];

	hardware.graphics = {
		enable = true;
		enable32Bit = true;

		extraPackages = with pkgs; [
			mesa.drivers
			libva
			libva-utils
		];

		extraPackages32 = with pkgs.pkgsi686Linux; [
			mesa.drivers
		];
	};

	environment.systemPackages = with pkgs; [
		clinfo
		libva-utils
		vulkan-tools
		amdgpu_top
	];
}
