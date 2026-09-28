{
	vars,
	lib,
	...
}: {
	boot.kernelModules = ["tcp_bbr" "ntsync"];
	# ++ lib.optionals vars.host.kernel.modules;
}
