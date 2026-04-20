{
	mainUser = "f";
	hostName = "p";
	bootLoader = "grub"; #GRUB LIMINE
	hardware = {
		bluetooth = true;
		wifi = true;

		sound = {
			rate = 192000;
		};

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
