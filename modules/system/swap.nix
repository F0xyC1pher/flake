{
	#config,
	#pkgs,
	...
}: {
	# Настройка Swap-файла
	swapDevices = [
		{
			device = "/var/lib/swapfile";
			size = 8 * 1024; # Размер в мегабайтах (тут 8 ГБ)
		}
	];
}
