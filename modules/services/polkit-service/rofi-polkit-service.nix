{pkgs, ...}: {
	environment.systemPackages = with pkgs; [
		rofi-polkit-agent
		cmd-polkit
		jq
	];
	systemd.user.services.rofi-polkit-agent = {
		description = "Rofi Polkit Agent";

		after = ["graphical-session.target"];
		partOf = ["graphical-session.target"];
		wantedBy = ["graphical-session.target"];

		serviceConfig = {
			ExecStart = "${pkgs.rofi-polkit-agent}/bin/rofi-polkit-agent";
			Restart = "on-failure";
			RestartSec = 1;
		};
	};
}
