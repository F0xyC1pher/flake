{...}: {
	systemd.extraConfig = ''
		DefaultCPUAccounting=no
		DefaultMemoryAccounting=no
		DefaultTasksAccounting=no
		DefaultBlockIOAccounting=no
		DefaultIPAccounting=no
	'';
}
