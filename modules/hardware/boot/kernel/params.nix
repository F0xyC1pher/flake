{
	boot.kernelParams = [
		"mitigations=off" # Дает ощутимый буст на Xeon X3450
		"preempt=full" # Low-latency отзывчивость
		"threadirqs" # Отличная связка с PipeWire
		"nmi_watchdog=0" # Экономит пару циклов CPU
	];
}
