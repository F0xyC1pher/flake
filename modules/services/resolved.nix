{...}: {
	services.resolved = {
		enable = true;

		settings = {
			Resolve = {
				# DNS = ["127.0.0.1:5300"];
				DNS = ["1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];
				FallbackDNS = ["1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];
				Domains = ["~."];
				DNSStubListener = false;
				# dnssec = "true";
				# dnsovertls = "true";
				# Add this to prevent fallback to per-link DNS
				ReadEtcHosts = true;
				# Игнорируем DNS, которые прилетают от VPN-ссылок
				# LLMNR = false;
				# MulticastDNS = false;
			};
		};
	};
}
