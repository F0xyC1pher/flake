{
	vars,
	lib,
	...
}: {
	imports =
		[]
		++ lib.optional vars.hardware.video.driver.nvidia.enable ./nvidia
		++ lib.optional vars.hardware.video.driver.amd.enable ./amd;
}
