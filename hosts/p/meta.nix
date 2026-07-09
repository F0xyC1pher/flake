{
	user = "f";
	host = "p";
	hardware = {
		boot = {
			loader = "limine"; # GRUB LIMINE
			# Диск для загрузчика (весь диск, не раздел)
			# Найти свой: ls -la /dev/disk/by-id/ | grep -v part
			device = "/dev/disk/by-id/ata-Smartbuy_SSD_128GB_LCN263R001798";
		};
		bluetooth.enable = true;
		wifi.enable = true;
		zram.enable = false;
		cpu.governor = "performance";
		kernel.type = "xanmod"; # xanmod, zen, hardened, latest
		parallels.enable = true;
		audio = {
			input = {
				noiseCancellation = true;
				rate.value = 48000;
				format = {
					prefix = "S"; # F S
					value = 16;
					suffix = "LE"; # LE P
				};
			};
			output = {
				rate.value = 192000;
				format = {
					prefix = "S"; # F S
					value = 32;
					suffix = "LE"; # LE P
				};
			};
		};

		nvidia = {
			enable = true;
			package = "legacy_580"; # "latest" "legacy_580" "legacy_470"
			perf = {
				# true для максимума | число для указания Ватт | "строка" процент Ватт от максимума | false | null
				value = true;
				persistence = true;
			};
		};
	};
}
