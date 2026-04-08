{
	# stdenv,
	#config,
	#pkgs,
	lib,
	# inputs,
	#vars,
	...
}: {
	imports = [
		./cups.nix
		./greetd.nix
		./gvfs.nix
		./locate.nix
		./logind.nix
		./mpd.nix
		./openssh.nix
		./pipewire.nix
		./udev.nix
		./xserver.nix
	];
	#	========== SERVICES ==========
	services = {
		dbus.enable = true;
		gnome.gnome-keyring.enable = lib.mkForce false;
		desktopManager.gnome.enable = lib.mkForce false;
	};
}
