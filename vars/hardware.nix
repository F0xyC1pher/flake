{	
	nixos-hw = "none"; # null или "none" чтобы отключить, строка для железа
	# (true или false)
	bluetooth = true;
	wifi = true;
	nvidia = {
		enable = true;# <- автообнаружение в будущем
		Laptop = false;
		Perfomance = {
			MaxWatts = true;
			PersistenceMode = true;	
		};
	};	
}
