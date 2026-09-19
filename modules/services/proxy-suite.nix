{...}: {
	services.proxy-suite = {
		enable = true;

		proxy = {
			enable = true;
			# singBox.enable = true;
			# Or use XRay instead:
			xray.enable = true;

			port = 1080;

			outbounds = [
				{
					tag = "an";
					url = "socks5://f:1@10.239.36.100:10808";
				}
			];
			# Automatic switching of outbound based on latency.
			# Default is "first", which just uses the first one in the list.
			selection = "urltest";

			# Keep both available; autostart only one global tunnel.
			tproxy.enable = false;
			tun = {
				enable = true;
				autostart = true;
				perApp.enable = true;
			};
		};

		zapret = {
			enable = true;
			perApp.enable = true;
		};

		perAppRouting = {
			enable = true;
			createDefaultProfiles = true;
			proxychains.enable = true;
		};

		tray = {
			enable = true;
			autostart = true;
		};

		tgWsProxy = {
			enable = true;
			port = 1443;
		};
	};
}
