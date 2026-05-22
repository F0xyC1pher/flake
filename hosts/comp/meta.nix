{
	user = "genius";
	host = "comp";
	hardware = {
		boot = {
			loader = "grub"; #GRUB LIMINE
			# Диск для загрузчика (весь диск, не раздел)
			# Найти свой: ls -la /dev/disk/by-id/ | grep -v part
			device = "/dev/disk/by-id/ata-WDC_WD3200LPVT-08G33T1_WD-WX41A5342859";
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
				prefix = "F"; # F S
				value = 32;
				suffix = "LE"; # LE P
			};
		};
		amd.enable = false;

		nvidia = {
			enable = false;
			package = "legacy_580"; # "latest" "legacy_580" "legacy_470"
			perf = {
				# true для максимума | число для указания Ватт | "строка" процент Ватт от максимума | false | null
				value = true;
				persistence = true;
			};
		};
	};
}
