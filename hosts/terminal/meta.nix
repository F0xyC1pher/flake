{
	user = "cicada";
	host = "terminal";
	hardware = {
		boot = {
			loader = "grub"; # GRUB LIMINE grub limine
			# Диск для загрузчика (весь диск, не раздел)
			# Найти свой: ls -la /dev/disk/by-id/ | grep -v part
			# device = "/dev/disk/by-id/";
		};
		bluetooth.enable = true;
		wifi.enable = true;
		zram.enable = false;
		cpu.governor = "performance";
		parallels.enable = true;
		kernel = {
			name = "latest"; # xanmod_latest, zen_latest, hardened, latest
			modules = ["asus_armoury"];
		};
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
				rate.value = 48000;
				format = {
					prefix = "S"; # F S
					value = 32;
					suffix = "LE"; # LE P
				};
			};
		};
		video = {
			output = {
				name = "HDMI-A-1";
				resolution = "1920x1080";
				framerate = "60.000";
			};
			driver = {
				amd = {
					enable = false;
					# type = "modern"; # modern - for new like RX ; legacy - for old like Radeon
				};
				nvidia = {
					enable = true;
					package = "latest"; # "latest" "legacy_580" "legacy_470"
					open = true;
					perf = {
						# true for maximum | number to indicate Watts | "string" percentage of watts from maximum | false | null
						value = true;
						persistence = true;
					};
				};
			};
		};
	};
}
