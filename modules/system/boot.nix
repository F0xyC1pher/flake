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
			"preempt=full" # Полная вытесняемость ядра
			"threadirqs" # Прерывания в потоках
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
