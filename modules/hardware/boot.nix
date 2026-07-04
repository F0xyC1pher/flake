{
	lib,
	pkgs,
	vars,
	...
}: {
	boot = {
		# ========== KERNEL ==========
		kernelPackages = pkgs.linuxPackages_xanmod_latest;

		initrd.systemd.enable = true;

		kernelParams = [
			"mitigations=off"
			"preempt=voluntary"
			"threadirqs"
			"nmi_watchdog=0"
			"nowatchdog"
			"transparent_hugepage=madvise"
			# "intel_idle.max_cstate=1"
			# "intel_pstate=passive"
		];

		kernel.sysctl = {
			# === Память ===
			"vm.swappiness" = 10;
			"vm.vfs_cache_pressure" = 50;
			"vm.dirty_ratio" = 8;
			"vm.dirty_background_ratio" = 3;
			"vm.dirty_expire_centisecs" = 3000;
			"vm.dirty_writeback_centisecs" = 1500;
			"vm.min_free_kbytes" = 262144;
			"vm.max_map_count" = 2147483642;
			"vm.panic_on_oom" = 0;

			# === Сеть ===
			"net.core.netdev_max_backlog" = 5000;
			"net.core.somaxconn" = 8192;
			"net.ipv4.tcp_max_syn_backlog" = 8192;
			"net.core.rmem_default" = 33554432;
			"net.core.rmem_max" = 33554432;
			"net.core.wmem_default" = 33554432;
			"net.core.wmem_max" = 33554432;
			"net.ipv4.tcp_rmem" = "4096 1048576 33554432";
			"net.ipv4.tcp_wmem" = "4096 1048576 33554432";
			"net.ipv4.udp_rmem_min" = 8192;
			"net.ipv4.udp_wmem_min" = 8192;
			"net.core.optmem_max" = 65536;

			"net.ipv4.tcp_window_scaling" = 1;
			"net.ipv4.tcp_sack" = 1;
			"net.ipv4.tcp_dsack" = 1;
			"net.ipv4.tcp_fack" = 0;
			"net.ipv4.tcp_timestamps" = 1;
			"net.ipv4.tcp_fastopen" = 3;
			"net.ipv4.tcp_slow_start_after_idle" = 0;
			"net.ipv4.tcp_congestion_control" = "bbr";
			"net.core.default_qdisc" = "fq_codel";

			"net.ipv4.ip_forward" = 1; # оставил по твоей просьбе
			"net.ipv4.ip_local_port_range" = "1024 65535";
			"net.ipv4.ping_group_range" = "0 2147483647";

			# === Системные лимиты ===
			"fs.file-max" = 2097152;
			"kernel.nmi_watchdog" = 0;

			# Полезно при высокой нагрузке
			"net.core.busy_poll" = 50;
			"net.core.busy_read" = 50;
		};

		# ========== BOOTLOADER ==========
		loader = let
			lowerLoader = lib.toLower vars.hardware.boot.loader;
		in
			if lowerLoader == "grub"
			then {
				grub.enable = true;
				grub.device = vars.hardware.boot.device;
				limine.enable = false;
			}
			else if lowerLoader == "limine"
			then {
				limine.enable = true;
				limine.biosDevice = vars.hardware.boot.device;
				limine.enableEditor = true;
				limine.extraConfig = ''
					remember_last_entry: yes
				'';
				grub.enable = false;
			}
			else throw "Unknown boot loader: ${vars.hardware.boot.loader}";
	};
}
