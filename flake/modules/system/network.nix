{ stdenv, config, pkgs, lib, inputs, vars, ... }:
{
	# ========== NETWORK ==========
	networking = {
		hostName = "${vars.hostName}";
		networkmanager = {
			enable = true;
			# dns = "systemd-resolved";
			dns = "none";
		};
		useDHCP = false;
		firewall.enable = false;
		nameservers = [
			"1.1.1.1"
			"1.0.0.1"
		];
		# hosts = {
		# 	"94.131.119.22" = [ "grok.com" "x.ai" "accounts.x.ai" ];
		# };
		wireless = {
			enable = true;
			userControlled = true;
		};
	};
# 	services.resolved = {
# 		enable = true;
# 
# 		settings = {
# 			Resolve = {
# 				DNS = [ "127.0.0.1:5300" ];
# 				FallbackDNS = [ ];
# 				Domains = [ "~." ];
# 			};
# 		};
# 	};
# 	services.dnscrypt-proxy = {
# 		enable = true;
# 
# 		settings = {
# 			listen_addresses = [ "127.0.0.1:5300" ];
# 
# 			server_names = [
# 				"cloudflare"
# 			];
# 
# 			ipv6_servers = false;
# 			require_dnssec = true;
# 
# 			cache = true;
# 			cache_size = 4096;
# 			
# 			sources.public-resolvers = {
# 				urls = [
# 					"https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
# 				];
# 				cache_file = "/var/lib/dnscrypt-proxy/public-resolvers.md";
# 			};
# 		};
# 	};
}
