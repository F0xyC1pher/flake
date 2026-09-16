{
	boot.kernel.sysctl = {
		# === Память ===
		"vm.swappiness" = 10;
		"vm.vfs_cache_pressure" = 50;
		"vm.max_map_count" = 2147483642; # Критично для Wine/Proton и тяжелых игр

		# === Сеть (безопасный буст для гигабита без busy_poll) ===
		"net.core.netdev_max_backlog" = 5000;
		"net.core.somaxconn" = 8192;
		"net.ipv4.tcp_max_syn_backlog" = 8192;
		"net.core.rmem_max" = 16777216;
		"net.core.wmem_max" = 16777216;
		"net.ipv4.tcp_rmem" = "4096 87380 16777216";
		"net.ipv4.tcp_wmem" = "4096 87380 16777216";
		"net.ipv4.tcp_fastopen" = 3;
		"net.ipv4.tcp_slow_start_after_idle" = 0;
		"net.ipv4.tcp_congestion_control" = "bbr";
		"net.core.default_qdisc" = "fq_codel";

		# Права и порты
		"net.ipv4.ip_local_port_range" = "1024 65535";
		"net.ipv4.ping_group_range" = "0 2147483647";

		# === Системные лимиты ===
		"fs.file-max" = 2097152;
	};
}
