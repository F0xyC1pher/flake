{
	config,
	pkgs,
	vars,
	...
}: {
	boot = {
		#	==========	KERNEL	==========
		kernelPackages = pkgs.linuxPackages_xanmod_latest;
		# Инициализация ядра
		initrd.kernelModules = ["tcp_bbr"];
		# Чёрный список ненужных модулей
		blacklistedKernelModules = [
			"snd_hda_codec_hdmi" # Если не используете HDMI audio
		];

		# Параметры ядра для real-time аудио
		kernelParams = [
			# Real-time настройки
			"preempt=full" # Полная вытесняемость (voluntary = частичная)
			"threadirqs" # Все IRQ как потоки
			"nmi_watchdog=0" # Отключаем NMI watchdog (снижает задержки)
			"rcu_nocbs=2-7" # RCU на выделенных ядрах
			"isolcpus=2-7" # Изоляция ядер 2-7
			"rcu_nocb_poll" # Позволяет RCU использовать изолированные ядра
			"nohz_full=2-7" # Отключаем тики на изолированных ядрах
			"nohz=on" # Включаем динамические тики
			"tsc=reliable" # Используем TSC как надежный источник времени

			# Управление питанием
			"processor.max_cstate=1" # Ограничиваем C-states (Intel)
			"intel_idle.max_cstate=0" # Отключаем глубокие C-states (Intel)

			# Управление памятью
			"transparent_hugepage=never" # Отключаем прозрачные огромные страницы
			"default_hugepagesz=2M" # Размер огромных страниц
			"hugepagesz=2M" # Для лучшего управления памятью

			# Управление прерываниями
			"irqaffinity=0-1" # Привязываем IRQ к первым ядрам
			"pcie_aspm=off" # Отключаем ASPM для PCIe (снижает задержки)

			# Отключаем ненужные функции безопасности для производительности
			"mitigations=off" # ОСТОРОЖНО! Отключает защиту от Spectre/Meltdown
		];
		kernel.sysctl = {
			# Управление памятью
			"vm.swappiness" = 10; # Меньше использовать swap
			"vm.vfs_cache_pressure" = 50; # Держим кэш дольше
			"vm.dirty_ratio" = 30; # Настройка грязных страниц
			"vm.dirty_background_ratio" = 5;

			# Огромные страницы для JACK/Ardour
			"vm.nr_hugepages" = 512; # 512MB для huge pages

			# Управление OOM
			"vm.panic_on_oom" = 0;
			"vm.oom_kill_allocating_task" = 1;
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
			# 4. УПРАВЛЕНИЕ ПАМЯТЬЮ (ваши настройки + аудио оптимизации)
			# ----------------------------------------------------------------------

			# Максимальное количество mmap (важно для аудио семплеров)
			"vm.max_map_count" = 16777216;

			# Dirty pages настройки (ваши значения)
			"vm.dirty_bytes" = 419430400; # 400MB
			"vm.dirty_background_bytes" = 209715200; # 200MB
			"vm.dirty_expire_centisecs" = 3000;
			"vm.dirty_writeback_centisecs" = 1500;

			# Минимальная свободная память (ваше значение)
			"vm.min_free_kbytes" = 103479;

			# ----------------------------------------------------------------------
			# 5. ДОПОЛНИТЕЛЬНЫЕ АУДИО-ОПТИМИЗАЦИИ
			# ----------------------------------------------------------------------
			# Отключаем NMI watchdog (уже в kernelParams, но дублируем)
			"kernel.nmi_watchdog" = 0;

			# Огромные страницы для аудио приложений
			"vm.hugetlb_shm_group" = 1000; # audio group

			# Улучшаем производительность ввода-вывода
			"vm.drop_caches" = 0; # Не сбрасываем кэш автоматически
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
		#	==========	BOOTLOADER	==========
		loader =
			if vars.bootLoader == "GRUB"
			then {
				grub.enable = true;
				grub.device = config.fileSystems."/boot".device;
				limine.enable = false;
			}
			else if vars.bootLoader == "Limine"
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
