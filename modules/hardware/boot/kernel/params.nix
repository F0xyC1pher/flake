{
	vars,
	lib,
	...
}: {
	boot.kernelParams =
		[
			"mitigations=off" # Дает ощутимый буст на Xeon X3450
			"preempt=full" # Low-latency отзывчивость
			# "threadirqs" # Отличная связка с PipeWire
			"nmi_watchdog=0" # Экономит пару циклов CPU
		]
		++ lib.optionals vars.host.hardware.video.driver.nvidia.enable [
			"nvidia-drm.modeset=1"
			"nvidia-drm.fbdev=1"
		]
		++ (vars.host.kernel.params or []);
}
