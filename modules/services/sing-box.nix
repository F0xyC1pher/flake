# sing-box.nix
{pkgs, ...}: {
	services.sing-box = {
		enable = true;

		settings = {
			log.level = "warn";

			inbounds = [
				{
					type = "tun";
					tag = "tun-in";
					interface_name = "singtun0";
					address = ["172.19.0.1/30"];
					auto_route = true;
					strict_route = true;
					stack = "system";
					dns_mode = "disabled";
				}
			];

			outbounds = [
				{
					type = "socks";
					tag = "phone-proxy";
					server = "phone.internal";
					server_port = 10808;
				}
			];

			route = {
				auto_detect_interface = true;
				rules = [
					{
						protocol = "dns";
						action = "hijack-dns";
					}
				];
				final = "phone-proxy";
			};
		};
	};

	systemd.services.sing-box.serviceConfig = {
		AmbientCapabilities = ["CAP_NET_ADMIN" "CAP_NET_BIND_SERVICE"];
		CapabilityBoundingSet = ["CAP_NET_ADMIN" "CAP_NET_BIND_SERVICE"];
	};
}
