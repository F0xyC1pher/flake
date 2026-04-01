{...}: {
	# Отключаем энергосбережение для USB
	services.udev.extraRules = ''
		# Увеличиваем приоритет звуковых IRQ
		SUBSYSTEM=="irq", ACTION=="add", ATTR{irq}=="*", ATTR{threaded}="1"

		# Настройка планировщика для дисков с аудио
		ACTION=="add|change", KERNEL=="sd*[!0-9]", ATTR{queue/scheduler}="none"

		# Для SSD
		ACTION=="add|change", KERNEL=="sd*[!0-9]", ATTR{queue/scheduler}="none"
		ACTION=="add|change", KERNEL=="nvme*", ATTR{queue/scheduler}="none"

		# Для HDD (если есть)
		# ACTION=="add|change", KERNEL=="sd*[!0-9]", ATTR{queue/scheduler}="bfq"

		# Отключаем автосуспенд для USB
		ACTION=="add", SUBSYSTEM=="usb", ATTR{power/control}="on"
		ACTION=="add", SUBSYSTEM=="usb", TEST=="power/autosuspend", ATTR{power/autosuspend}="0"

		# Для звуковых карт
		SUBSYSTEM=="sound", ACTION=="add", ATTR{power/control}="on"
		SUBSYSTEM=="pci", ACTION=="add", DRIVER=="snd_hda_intel", ATTR{power/control}="on"

		# Для USB звуковых интерфейсов
		SUBSYSTEM=="usb", ATTR{idVendor}=="*", ATTR{idProduct}=="*", ATTR{power/control}="on"

	'';
}
