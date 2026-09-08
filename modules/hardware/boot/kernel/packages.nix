{
	vars,
	pkgs,
	...
}: {
	boot.kernelPackages = pkgs."linuxPackages_${vars.host.kernel.name}";
}
