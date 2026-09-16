{pkgs, ...}: {
	environment.systemPackages = with pkgs; [
		custom.fuzzel-polkit-agent
		cmd-polkit
		jq
	];
	systemd.user.services.fuzzel-polkit-agent = {
		description = "Fuzzel Polkit Agent";

		after = ["graphical-session.target"];
		partOf = ["graphical-session.target"];
		wantedBy = ["graphical-session.target"];

		serviceConfig = {
			ExecStart = "${pkgs.custom.fuzzel-polkit-agent}/bin/fuzzel-polkit-agent";
			Restart = "on-failure";
			RestartSec = 1;
		};
	};
}
