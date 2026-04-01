{vars, ...}: {
	# ========== NETWORK ==========
	networking = {
		hostName = "${vars.hostName}";
		networkmanager = {
			enable = true;
			dns = "systemd-resolved";
			# dns = "none";
			insertNameservers = ["127.0.0.1"];
		};
		useDHCP = false;
		firewall = {
			enable = false;
			# trustedInterfaces = ["ztpp6h5cno"];
		};
		# proxy.default = "";
		# proxy.noProxy = "127.0.0.1,localhost,internal.domain";
		# nameservers = [
		# 	"1.1.1.1"
		# 	"1.0.0.1"
		# ];
		# hosts = {
		# 	"94.131.119.22" = [ "grok.com" "x.ai" "accounts.x.ai" ];
		# };
		# wireless = {
		# 	enable = true;
		# 	userControlled = true;
		# };
	};

	services.resolved = {
		enable = true;

		settings = {
			Resolve = {
				DNS = ["127.0.0.1:5300"];
				FallbackDNS = [""];
				Domains = ["~."];
				DNSStubListener = false;
				# Add this to prevent fallback to per-link DNS
				ReadEtcHosts = true;
				# Игнорируем DNS, которые прилетают от VPN-ссылок
				LLMNR = false;
				MulticastDNS = false;
			};
		};
	};

	services.dnscrypt-proxy = {
		enable = true;

		settings = {
			listen_addresses = ["127.0.0.1:5300"];
			bootstrap_resolvers = ["1.1.1.1:53"];
			server_names = [
				"cloudflare"
			];
			# Force DoH and DNSCrypt, disable plain old DNS
			doh_servers = true;
			dnscrypt_servers = true;

			# Ensure we are using encrypted protocols only
			require_nolog = true;
			require_dnssec = true;

			ipv6_servers = true;

			cache = true;
			cache_size = 4096;

			sources.public-resolvers = {
				urls = [
					"https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
				];
				cache_file = "/var/lib/dnscrypt-proxy/public-resolvers.md";
				minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
			};
		};
	};
}
