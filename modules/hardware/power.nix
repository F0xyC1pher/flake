{vars, ...}: {
	powerManagement = {
		enable = true;
		cpuFreqGovernor = "${vars.hardware.cpu.governor}";
	};
}
