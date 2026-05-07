{
	config,
	lib,
	modulesPath,
	...
}: {
	imports = [
		(modulesPath + "/installer/scan/not-detected.nix")
	];

	boot.initrd.availableKernelModules = [
		"nvme"
		"xhci_pci"
		"usb_storage"
		"usbhid"
		"sd_mod"
		"sr_mod"
	];
	boot.initrd.kernelModules = [];
	boot.kernelModules = ["kvm-amd"];
	boot.extraModulePackages = [];

	fileSystems."/" = {
		device = "";
		fsType = "btrfs";
		options = ["subvol=@"];
	};

	boot.initrd.luks.devices."".device = "";

	fileSystems."/boot" = {
		device = "";
		fsType = "vfat";
		options = [
			"fmask=0077"
			"dmask=0077"
		];
	};

	fileSystems."/home" = {
		device = "";
		fsType = "btrfs";
	};

	boot.initrd.luks.devices."".device = "";

	swapDevices = [
		{device = "";}
	];

	nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
	hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
