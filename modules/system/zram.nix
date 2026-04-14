{...}: {
	zramSwap = {
		enable = true;
		algorithm = "zstd";
		memoryPercent = 150;
		priority = 100; # максимальный приоритет
	};
}
