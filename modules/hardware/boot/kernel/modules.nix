{vars, ...}: {
	boot.kernelModules =
		["tcp_bbr" "ntsync"]
		++ (vars.host.kernel.modules or []);
}
