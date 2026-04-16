{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {pkgs, ...}: {
			# Сервис Dropbox через Home Manager
			systemd.user.services.dropbox = {
				Unit = {
					Description = "Dropbox service";
					After = ["network.target" "graphical-session.target"];
				};
				Install = {
					WantedBy = ["default.target"];
				};
				Service = {
					ExecStart = "${pkgs.dropbox}/bin/dropbox";
					Restart = "on-failure";
					RestartSec = 10;
					# Опционально: окружение для графики и Qt
					Environment = [
						#"DISPLAY=:0"
						"QT_PLUGIN_PATH=${pkgs.qt5.qtbase}/${pkgs.qt5.qtbase.qtPluginPrefix}"
						"QML2_IMPORT_PATH=${pkgs.qt5.qtbase}/${pkgs.qt5.qtbase.qtQmlPrefix}"
					];
				};
			};
		};
	};
}
