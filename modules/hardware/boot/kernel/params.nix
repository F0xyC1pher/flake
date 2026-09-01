{
	boot.kernelParams = [
		"mitigations=off"
		"preempt=full"
		"threadirqs"
		"nmi_watchdog=0"
		"nowatchdog"
		# "intel_idle.max_cstate=1"
		# "intel_pstate=passive"
	];
}
