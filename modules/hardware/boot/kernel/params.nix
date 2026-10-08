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
	boot.extraModprobeConfig = ''
		options snd_hda_intel power_save=0
		options snd_hda_codec_hdmi power_save=0
	'';
}
