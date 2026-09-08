{
	vars,
	lib,
	...
}: {
	imports =
		[]
		++ lib.optional vars.host.hardware.video.driver.nvidia.enable ./nvidia
		++ lib.optional vars.host.hardware.video.driver.amd.enable ./amd;
}
