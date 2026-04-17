{...}: {
	imports = [
		# ./awww-daemon.nix
		./fuzzel-polkit-service.nix
		# ./rofi-polkit-service.nix
		# ./waybar-s.nix
	];
	systemd = {
		# Вместо extraConfig используем settings
		settings = {
			Manager = {
				DefaultCPUAccounting = "no";
				DefaultMemoryAccounting = "no";
				DefaultTasksAccounting = "no";
				DefaultBlockIOAccounting = "no";
				DefaultIPAccounting = "no";
			};
		};
	};
}
