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
		SUBSYSTEM=="irq", ACTION=="add", ATTR{irq}=="*", ATTR{threaded}="1"

		# Для SSD
		ACTION=="add|change", KERNEL=="sd*[!0-9]", ATTR{queue/scheduler}="none"
		ACTION=="add|change", KERNEL=="nvme*", ATTR{queue/scheduler}="none"

		# Для HDD (если есть)
		ACTION=="add|change", KERNEL=="sd*[!0-9]", ATTR{queue/scheduler}="bfq"


		# USB audio — максимальный приоритет
		# SUBSYSTEM=="usb", ATTR{idVendor}=="1235", ATTR{idProduct}=="*", GROUP="audio", MODE="0660", RUN+="/bin/sh -c 'echo 0 > /proc/irq/$(cat /proc/interrupts | grep -m1 "USB" | cut -d: -f1 | tr -d " ") /smp_affinity_list'"

		# Gamepad / mouse / keyboard — low latency
		KERNEL=="event*", ATTR{name}=="*Mouse*|*Keyboard*|*Gamepad*", GROUP="input", MODE="0660"
	'';
}
