{...}: {
	services.tlp = {
		enable = true;
		settings = {
			# Ensure max performance when plugged into AC power
			CPU_SCALING_GOVERNOR_ON_AC = "performance";
			CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

			# Prevent PCIe link power management from throttling GPU bandwidth
			PCIE_ASPM_ON_AC = "performance";

			# Keep USB power saving off on AC for low input latency
			USB_AUTOSUSPEND_DISABLE_ON_AC = 1;
		};
	};
}
