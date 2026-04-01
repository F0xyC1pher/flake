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
		initrd.kernelModules = ["snd-usb-audio" "snd-hda-intel" "tcp_bbr"];
		# Чёрный список ненужных модулей
		blacklistedKernelModules = [
			"pcspkr" # Пищалка
			"snd_pcsp" # PC Speaker
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
