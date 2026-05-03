{...}: {
	boot.tmp = {
		# useTmpfs = true;
		# tmpfsSize = "40%";
		tmpfsHugeMemoryPages = "within_size";
		useZram = true;
		zramSettings = {
			zram-size = "ram * 0.5";
			compression-algorithm = "zstd";
			fs-type = "btrfs";
			options = "X-mount.mode=1777,discard";
		};
	};
}
