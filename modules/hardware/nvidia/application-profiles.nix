{
	vars,
	inputs,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			home.file.".nv/nvidia-application-profiles-rc" = {
				text = ''
					{
						"rules": [
							{
								"profile": "Limit_Free_Buffer"
								"pattern": {
									"feature": "procname",
									"matches": "niri"
								},
							}
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
								"name": "Limit_Free_Buffer",
								"settings": [
									{
										"key": "GLVidHeapReuseRatio",
										"value": 0
									}
								]
							}
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
