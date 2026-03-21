{ config, pkgs, lib, inputs, vars, ... }:
{
	environment = {
		etc = {
			"nvidia/nvidia-application-profiles-rc.d/50-niri-limit-buffer-pool.json" = {
				text = ''
					{
						"rules": [
							{
								"profile": "Limit Free Buffer Pool On Wayland Compositors"
								"pattern": {
									"feature": "procname",
									"matches": "niri"
								},
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
			"nvidia/nvidia-application-profiles-rc.d/50-gl-threaded-optimizations-bug-fix.json" = {
				text = ''
					{
						"rules": [
							{
								"profile": "openGL_fix"
								"pattern": {
									"feature": "dso",
									"matches": "libGL.so.1"
								},
							}
						],
						"profiles": [
							{
								"name": "openGL_fix",
								"settings": [
									{
										"key": "GLThreadedOptimizations",
										"value": false
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
