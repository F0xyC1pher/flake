{...}: {
	services.zerotierone = {
		enable = true;
		joinNetworks = [
			"88c5b1f339cf7a97"
		];
		localConf = {
			settings = {
				bind = ["0.0.0.0:9993" "[::]:9993"];
			};
		};
	};
}
