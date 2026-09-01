{...}: {
	boot.initrd.systemd.enable = true;
	imports = [
		./kernel
		./loader.nix
	];
}
