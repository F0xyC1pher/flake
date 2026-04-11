{
	mainUser = "f";
	hostName = "p";
	bootLoader = "GRUB";
	hardware = {
		bluetooth = true;
		wifi = true;
		nvidia = {
			enable = true;
			Laptop = false;
			Perfomance = {
				MaxWatts = true;
				PersistenceMode = true;
			};
		};
	};
}
