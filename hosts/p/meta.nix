{
	host = {
		user = "f";
		parallels.enable = true;
		boot = {
			loader = "grub"; # GRUB LIMINE grub limine
			device = "/dev/disk/by-id/ata-Smartbuy_SSD_128GB_LCN263R001798"; # Find your disk for bootloader: ls -la /dev/disk/by-id/ | grep -v part
		};
		kernel = {
			name = "xanmod_latest"; # xanmod_latest, zen_latest, hardened, latest
			# modules = [];
		};
		swap = {
			enable = true;
			# size = 16; # not needed when ram exists
		};
		zram = {
			enable = true;
			#percent = 100; # not needed when ram exists
		};
		hardware = {
			ram = 16;
			bluetooth.enable = true;
			cpu.governor = "performance";
			wifi.enable = true;
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
						prefix = "F"; # F S
						value = 32;
						suffix = "LE"; # LE P
					};
				};
			};
			video = {
				output = {
					framerate = "60.000";
					name = "HDMI-A-1";
					resolution = "1600x900";
				};
				driver = {
					amd = {
						enable = false;
						type = "modern"; # modern - for new like RX ; legacy - for old like Radeon
					};
					nvidia = {
						enable = true;
						open = false;
						package = "legacy_580"; # "latest" "legacy_580" "legacy_470"
						perf = {
							# true for maximum | number to indicate Watts | "string" percentage of watts from maximum | false | null
							value = true;
							persistence = true;
						};
					};
				};
			};
		};
	};
}
