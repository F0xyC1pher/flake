{...}: {
	services.logind = {
		settings = {
			Login = {
				HandleLidSwitch = "ignore";
				HandleLidSwitchExternalPower = "ignore";
				HandleLidSwitchDocked = "ignore";
				IdleAction = "ignore";
				KillUserProcesses = true;
				KillExcludeUsers = ["root"];
			};
		};
	};
}
