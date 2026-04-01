{...}: {
	# Оптимизация logind
	logind = {
		extraConfig = ''
			HandleLidSwitch=ignore
			IdleAction=ignore
			KillUserProcesses=no
		'';
	};
}
