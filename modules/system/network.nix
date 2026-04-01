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
		# Оптимизация сетевых параметров
		extraSysctl = {
			# ----------------------------------------------------------------------
			# 1. ОСНОВНЫЕ НАСТРОЙКИ СЕТИ И ПРОИЗВОДИТЕЛЬНОСТЬ
			# ----------------------------------------------------------------------
			"net.core.netdev_max_backlog" = 16384;
			"net.core.somaxconn" = 8192;
			"net.ipv4.tcp_max_syn_backlog" = 8192;

			# Увеличенные буферы (ваши настройки)
			"net.core.rmem_default" = 33554432;
			"net.core.rmem_max" = 33554432;
			"net.core.wmem_default" = 33554432;
			"net.core.wmem_max" = 33554432;
			"net.ipv4.tcp_rmem" = "4096 1048576 33554432";
			"net.ipv4.tcp_wmem" = "4096 1048576 33554432";

			# UDP настройки
			"net.ipv4.udp_rmem_min" = 8192;
			"net.ipv4.udp_wmem_min" = 8192;
			"net.core.optmem_max" = 65536;

			# ----------------------------------------------------------------------
			# 2. АЛГОРИТМЫ TCP
			# ----------------------------------------------------------------------
			"net.ipv4.tcp_congestion_control" = "bbr";
			"net.ipv4.tcp_window_scaling" = 1;
			"net.ipv4.tcp_sack" = 1;
			"net.ipv4.tcp_dsack" = 1;
			"net.ipv4.tcp_fack" = 0;
			"net.ipv4.tcp_timestamps" = 1;
			"net.ipv4.tcp_fastopen" = 3;
			"net.ipv4.tcp_low_latency" = 1;

			# ----------------------------------------------------------------------
			# 3. МАРШРУТИЗАЦИЯ
			# ----------------------------------------------------------------------
			"net.ipv4.ip_forward" = 1;
			"net.ipv4.ip_local_port_range" = "1024 65535";
			"net.ipv4.ping_group_range" = "0 2147483647";

			# ----------------------------------------------------------------------
			# 6. ДОПОЛНИТЕЛЬНЫЕ СЕТЕВЫЕ ОПТИМИЗАЦИИ ДЛЯ НИЗКОЙ ЗАДЕРЖКИ
			# ----------------------------------------------------------------------
			# Отключаем IPv6 если не нужен (снижает задержки)
			# "net.ipv6.conf.all.disable_ipv6" = 1;
			# "net.ipv6.conf.default.disable_ipv6" = 1;

			# Оптимизация для low-latency сетей (NFS, аудио стриминг)
			"net.ipv4.tcp_ecn" = 0; # Отключаем ECN для снижения задержек

			# Увеличиваем буферы для multicast (аудио стриминг)
			"net.ipv4.igmp_max_memberships" = 1024;
			# ----------------------------------------------------------------------
			# 7. БЕЗОПАСНОСТЬ И СТАБИЛЬНОСТЬ
			# ----------------------------------------------------------------------
			# Защита от SYN flood
			"net.ipv4.tcp_syncookies" = 1;

			# Защита от ICMP redirect
			"net.ipv4.conf.all.accept_redirects" = 0;
			"net.ipv4.conf.default.accept_redirects" = 0;
			"net.ipv4.conf.all.secure_redirects" = 0;

			"net.core.busy_poll" = 50;
			"net.core.busy_read" = 50;
		};
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
