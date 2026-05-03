{pkgs, ...}: {
	services = {
		udev = {
			enable = true;
			packages = with pkgs; [
				game-devices-udev-rules
			];

			# Отключаем энергосбережение для USB
			extraRules = ''
				# --- СХЕМА ПРИОРИТЕТОВ IRQ ---
				# Включаем threading для IRQ звуковых карт (HDA Intel и USB)
				# Это позволяет rtkit лучше управлять их приоритетом
				SUBSYSTEM=="irq", ATTR{threaded}="1"

				# --- USB AUDIO (MUSIC-BOOST Microphone) ---
				# Отключаем агрессивное энергосбережение, которое дает щелчки
				SUBSYSTEM=="usb", ATTR{idVendor}=="*", ATTR{idProduct}=="*", ATTR{product}=="*Usb Microphone*", ATTR{power/control}="on", ATTR{power/autosuspend}="-1"

				# --- ДИСКОВАЯ ПОДСИСТЕМА ---
				# NVMe и SSD без планировщика для минимального CPU overhead
				ACTION=="add|change", KERNEL=="nvme*", ATTR{queue/scheduler}="none"
				ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="none"
				# Только для крутящихся HDD оставляем bfq
				ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", ATTR{queue/scheduler}="bfq"

				# --- ИНПУТЫ (Мышь/Клавиатура) ---
				# Убираем задержки опроса для USB устройств ввода
				ACTION=="add|change", SUBSYSTEM=="usb", ATTRS{idVendor}=="*", ATTR{bInterfaceClass}=="03", ATTR{power/control}="on", ATTR{power/autosuspend}="-1"
			'';
		};
	};
}
