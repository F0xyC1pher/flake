{
	config,
	pkgs,
	vars,
	...
}: {
	boot = {
		#	==========	KERNEL	==========
		kernelPackages = pkgs.linuxPackages_xanmod_latest;
		kernelModules = ["snd-usb-audio"];
		kernelParams = [
			"preempt=full"
			"threadirqs"
			"nmi_watchdog=0"
			"rcu_nocbs=2-7"

			# Дополнительные оптимизации
			"irqaffinity=0-1" # Привязываем IRQ к первым ядрам
			"isolcpus=2-7" # Изолируем ядра для реального времени
			"nohz_full=2-7" # Отключаем таймеры на изолированных ядрах
			"nohz=on"
			"tsc=reliable"
			"rcu_nocb_poll" # Позволяет RCU использовать изолированные ядра
			"processor.max_cstate=1" # Ограничение C-states для снижения задержек
			"intel_idle.max_cstate=0" # Для Intel (если у вас Intel)
		];
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
