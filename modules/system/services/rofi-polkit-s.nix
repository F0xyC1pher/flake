{pkgs, ...}: {
	systemd.user.services.rofi-polkit-agent = {
		description = "Rofi Polkit Agent";

		# Эти параметры в NixOS пишутся на верхнем уровне конфига сервиса
		after = ["graphical-session.target"];
		partOf = ["graphical-session.target"];

		serviceConfig = {
			# Оверлей подставит сюда твой пакет из packages/rofi-polkit-agent.nix
			ExecStart = "${pkgs.rofi-polkit-agent}/bin/rofi-polkit-agent";
			Restart = "on-failure";
			RestartSec = 1;
		};

		# Для системных юнитов NixOS используется именно этот атрибут
		wantedBy = ["graphical-session.target"];
	};
}
