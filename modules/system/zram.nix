{...}: {
	zramSwap = {
		enable = true;
		algorithm = "zstd";
		memoryPercent = 200;
		priority = 100; # максимальный приоритет
	};
}
