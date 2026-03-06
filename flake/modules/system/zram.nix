{ config, pkgs, ... }:

{
	# Отключаем zswap
	boot.kernelParams = [
		"zswap.enabled=0"
	];
	
	zramSwap = {
		enable = true;
		algorithm = "zstd";
		memoryPercent = 100;          # или 150
		priority = 100;               # максимальный приоритет
	};
}
