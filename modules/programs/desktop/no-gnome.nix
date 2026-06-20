{lib, ...}: {
	programs.niri.useNautilus = false;
	services = {
		gnome.gnome-keyring.enable = lib.mkForce false;
		desktopManager.gnome.enable = lib.mkForce false;
	};
}
