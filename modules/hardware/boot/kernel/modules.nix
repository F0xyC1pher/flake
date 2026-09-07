{vars, ...}: {
	boot.kernelModules = [] ++ vars.hardware.kernel.modules;
}
