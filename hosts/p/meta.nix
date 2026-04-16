{
	mainUser = "f";
	hostName = "p";
	bootLoader = "GRUB";
	hardware = {
		bluetooth = true;
		wifi = true;

		sound = {
			rate = 48000;
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
