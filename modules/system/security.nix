{...}: {
	security = {
		sudo.wheelNeedsPassword = false;
		rtkit.enable = true;
		polkit.enable = true;
	};
}
