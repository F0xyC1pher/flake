{
	lib,
	config,
	pkgs,
	vars,
	...
}: {
	imports = [
		./tmp.nix
	];
	boot = {
		#	==========	KERNEL	==========
		kernelPackages = pkgs.linuxPackages_xanmod_latest;
		initrd.systemd.enable = true;

		kernelParams = [
			"mitigations=off"
			"preempt=full"
			"threadirqs"
			"nmi_watchdog=0"
			"nowatchdog"
			"tsc=reliable"
			"split_lock_detect=off"
			"transparent_hugepage=madvise"
			"pcie_aspm=off"
		];
		kernel.sysctl = {
			# "kernel.sched_child_runs_first" = 0;
			# "kernel.sched_autogroup_enabled" = 1;
			# "kernel.sched_cfs_bandwidth_slice_us" = 3000;
			# "kernel.sched_latency_ns" = 4000000;
			# "kernel.sched_min_granularity_ns" = 500000;
			# "kernel.sched_wakeup_granularity_ns" = 1000000;
			"vm.swappiness" = 10;
			"vm.vfs_cache_pressure" = 50;
			"vm.dirty_ratio" = 6;
			"vm.dirty_background_ratio" = 3;
			"vm.panic_on_oom" = 0;
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
			"net.core.default_qdisc" = "fq";
			"net.ipv4.tcp_congestion_control" = "bbr";
			"net.ipv4.tcp_window_scaling" = 1;
			"net.ipv4.tcp_sack" = 1;
			"net.ipv4.tcp_dsack" = 1;
			"net.ipv4.tcp_fack" = 0;
			"net.ipv4.tcp_timestamps" = 1;
			"net.ipv4.tcp_fastopen" = 3;
			"net.ipv4.tcp_slow_start_after_idle" = 0;
			"net.ipv4.ip_forward" = 1;
			"net.ipv4.ip_local_port_range" = "1024 65535";
			"net.ipv4.ping_group_range" = "0 2147483647";
			"vm.max_map_count" = 2147483642;
			"vm.dirty_expire_centisecs" = 3000;
			"vm.dirty_writeback_centisecs" = 1500;
			"vm.min_free_kbytes" = 262144;
			"kernel.nmi_watchdog" = 0;
			"vm.drop_caches" = 0;
			# "net.ipv4.tcp_ecn" = 0;
			# "net.ipv4.tcp_syncookies" = 1;
			"net.core.busy_poll" = 50;
			"net.core.busy_read" = 50;
			"fs.file-max" = 2097152;
		};
		#	==========	BOOTLOADER	==========
		loader = let
			lowerLoader = lib.toLower vars.bootLoader;
		in
			if lowerLoader == "grub"
			then {
				grub.enable = true;
				grub.device = config.fileSystems."/boot".device;
				limine.enable = false;
			}
			else if lowerLoader == "limine"
			then {
				limine.enable = true;
				limine.biosDevice = config.fileSystems."/boot".device;
				limine.enableEditor = true;
				limine.extraConfig = ''
					remember_last_entry: yes
				'';
				grub.enable = false;
			}
			else throw "Unknown boot loader: ${vars.bootLoader}";
	};
}
