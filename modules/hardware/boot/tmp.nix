{vars, ...}: {
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
	systemd.tmpfiles.rules = [
		# Создает папку для кеша в /tmp (который в zram)
		"d /tmp/user-cache 0700 ${vars.userName} users - -"
		# Создает симлинк из .cache в /tmp/user-cache
		# 'L' создает ссылку, '+' заставляет перезаписывать существующую папку
		"L+ /home/${vars.userName}/.cache - - - - /tmp/user-cache"
	];
}
