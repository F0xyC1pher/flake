{
	#config,
	#pkgs,
	...
}: {
	# Отключаем zswap
	boot.kernelParams = [
		"zswap.enabled=1"
	];

	zramSwap = {
		enable = false;
		algorithm = "zstd";
		memoryPercent = 100; # или 150
		priority = 100; # максимальный приоритет
	};
}
