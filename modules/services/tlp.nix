{...}: {
	services.tlp = {
		enable = true;
		settings = {
			# Ensure max performance when plugged into AC power
			CPU_SCALING_GOVERNOR_ON_AC = "schedutil";
			CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";
			CPU_ENERGY_PERF_POLICY_ON_AC = "schedutil";
			# Prevent PCIe link power management from throttling GPU bandwidth
			PCIE_ASPM_ON_AC = "schedutil";

			# Keep USB power saving off on AC for low input latency
			USB_AUTOSUSPEND_DISABLE_ON_AC = 1;
		};
	};
}
