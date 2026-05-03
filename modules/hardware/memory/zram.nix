{...}: {
	zramSwap = {
		enable = true;
		algorithm = "zstd";
		memoryPercent = 30;
		priority = 100;
	};
	boot.tmp.useZram = true;
}
