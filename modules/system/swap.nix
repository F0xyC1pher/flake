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

	# Опционально: можно подкрутить swappiness
	# 10 означает, что система будет использовать swap только в крайнем случае
	boot.kernel.sysctl = {
		"vm.swappiness" = 10;
	};
}
