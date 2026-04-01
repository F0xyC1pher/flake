{...}: {
	# Скрипт для настройки приоритетов IRQ
	systemd.services.setup-rtirq = {
		description = "Setup real-time IRQ priorities";
		after = ["systemd-udevd.service"];
		wantedBy = ["multi-user.target"];
		serviceConfig = {
			Type = "oneshot";
			RemainAfterExit = true;
		};
		script = ''
			# Находим IRQ звуковой карты
			for irq in $(ls /proc/irq | grep -E '^[0-9]+$'); do
			  if grep -q "snd\|audio\|hda" /proc/irq/$irq/smp_affinity 2>/dev/null; then
			    echo "Setting RT priority for IRQ $irq"
			    echo 98 > /proc/irq/$irq/threaded 2>/dev/null || true
			  fi
			done

			# Устанавливаем приоритеты для аудио IRQ
			echo 95 > /proc/irq/default_smp_affinity 2>/dev/null || true
		'';
	};
}
