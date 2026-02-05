{ config, pkgs, lib, inputs, vars, ... }:
{
	# ========== NVIDIA ==========
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
	environment = {
		etc = {
			"nvidia/nvidia-application-profiles-rc.d/50-niri-limit-buffer-pool.json" = {
				text = ''
					{
						"rules": [
							{
								"pattern": {
									"feature": "procname",
									"matches": "niri"
								},
								"profile": "Limit Free Buffer Pool On Wayland Compositors"
							}
						],
						"profiles": [
							{
								"name": "Limit Free Buffer Pool On Wayland Compositors",
								"settings": [
									{
										"key": "GLVidHeapReuseRatio",
										"value": 0
									}
								]
							}
						]
					}
				'';
			};
		};
	};
}
