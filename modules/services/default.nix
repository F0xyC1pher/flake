{...}: {
	imports = [
		./polkit-service
		./arrpc.nix
		./awww.nix
		./cliphist.nix
		./cups.nix
		./dbus.nix
		# ./dnscrypt-proxy.nix
		./dropbox.nix
		# ./earlyloom.nix
		# ./envfs.nix
		./greetd.nix
		./gvfs.nix
		./irqbalance.nix
		./locate.nix
		# ./logind.nix
		# ./logmein-hamachi.nix
		./mpd.nix
		./openssh.nix
		./pipewire.nix
		./playerctld.nix
		./resolved.nix
		./seatd.nix
		./udev.nix
		./upower.nix
		./userborn.nix
		./xserver.nix
	];
}
