{pkgs, ...}: {
	services = {
		udev = {
			packages = with pkgs; [
				game-devices-udev-rules
			];
		};
	};
	# Отключаем энергосбережение для USB
	services.udev.extraRules = ''
		# Увеличиваем приоритет звуковых IRQ
		# SUBSYSTEM=="irq", ACTION=="add", ATTR{irq}=="*", ATTR{threaded}="1"

		# Для SSD
		ACTION=="add|change", KERNEL=="sd*[!0-9]", ATTR{queue/scheduler}="none"
		ACTION=="add|change", KERNEL=="nvme*", ATTR{queue/scheduler}="none"

		# Для HDD (если есть)
		ACTION=="add|change", KERNEL=="sd*[!0-9]", ATTR{queue/scheduler}="bfq"
	'';
}
