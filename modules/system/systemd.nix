{...}: {
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
