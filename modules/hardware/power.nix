{vars, ...}: {
	powerManagement = {
		enable = true;
		cpuFreqGovernor = "${vars.host.hardware.cpu.governor}";
	};
}
