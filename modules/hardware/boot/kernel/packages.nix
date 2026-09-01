{
	vars,
	pkgs,
	...
}: {
	boot.kernelPackages = pkgs."linuxPackages_${vars.hardware.kernel.name}";
}
