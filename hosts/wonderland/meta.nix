{
	host = {
		user = "alice"; # Target username matching a profile in users/ :String

		parallels.enable = true; # Enable Parallels Desktop guest integrations :Boolean

		boot = {
			loader = "grub"; # Options: "grub", "limine", "GRUB", "LIMINE" :String
			device = "/dev/disk/by-id/"; # Disk path for bootloader (ls -la /dev/disk/by-id/ | grep -v part) :String
		};

		kernel = {
			name = "latest"; # Options: "xanmod_latest", "zen_latest", "hardened", "latest" :String
			# modules = []; # Extra out-of-tree kernel modules :List(String)
		};

		# Dynamic Memory Allocation (Automated paging & compression)
		swap = {
			enable = true; # Enable disk swapfile (/var/lib/swapfile) :Boolean
			# size = 16; # (Optional) Explicit GB size; defaults to hardware.ram :Integer
		};

		zram = {
			enable = true; # Enable compressed RAM block device :Boolean
			# percent = 100; # (Optional) Override adaptive calculation :Integer
		};

		hardware = {
			ram = 16; # System RAM in GB (used for zRAM & Swap calculation) :Integer
			bluetooth.enable = true; # Enable Bluetooth hardware stack :Boolean
			wifi.enable = true; # Enable Wireless networking support :Boolean
			cpu.governor = "performance"; # Options: "performance", "powersave", "ondemand", "schedutil" :String

			audio = {
				input = {
					noiseCancellation = true; # Enable LADSPA RNNoise filter chain on mic :Boolean
					rate.value = 48000; # Options: 48000, 96000, 192000 :Integer
					format = {
						prefix = "S"; # Options: "F", "S" :String
						value = 16; # Bit depth (16, 24, 32) :Integer
						suffix = "LE"; # Endianness: "LE", "BE", "P" :String
					};
				};
				output = {
					rate.value = 96000; # Options: 48000, 96000, 192000 :Integer
					format = {
						prefix = "S"; # Options: "F", "S" :String
						value = 32; # Options: 16, 24, 32 :Integer
						suffix = "LE"; # Options: "LE", "BE", "P" :String
					};
				};
			};

			video = {
				output = {
					name = "HDMI-A-1"; # Display connector identifier :String
					resolution = "1920x1080"; # Options: "YxZ" :IntegerxInteger-in-String
					framerate = "60.000"; # Options: "XXX.YYY" :Float-in-String
				};
				driver = {
					amd = {
						enable = false; # Enable AMD GPU driver stack :Boolean
						# type = "modern"; # Options: "modern" (RX+), "legacy" (Radeon<) :String
					};
					nvidia = {
						enable = true; # Enable NVIDIA GPU driver stack :Boolean
						package = "latest"; # Options: "latest", "legacy_580", "legacy_470" :String
						open = true; # Use open-source kernel modules (Turing+) :Boolean
						perf = {
							value = true; # Options: true for maximum | Watts :Integer | "%" :String | false | null
							persistence = true; # Enable nvidia-persistenced daemon :Boolean
						};
					};
				};
			};
		};
	};
}
