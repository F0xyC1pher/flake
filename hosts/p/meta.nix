{
	user = "f";
	host = "p";
	hardware = {
		boot = {
			loader = "grub"; #GRUB LIMINE
				# Диск для загрузчика (весь диск, не раздел)
	# Найти свой: ls -la /dev/disk/by-id/ | grep -v part
			device = "/dev/disk/by-id/ata-Smartbuy_SSD_128GB_LCN263R001798";
		};
		bluetooth = true;
		wifi = true;
		zram.enable = true;
		cpu.governor = "performance";
		kernel.type = "xanmod"; # xanmod, zen, hardened, default

		audio = {
			noiseCancellation = true;
			rate = 192000;
			format = {
				prefix = "FLOAT"; # FLOAT S
				value = 32;
				suffix = "LE";
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
