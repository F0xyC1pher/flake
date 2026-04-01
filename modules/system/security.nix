{pkgs, ...}: {
	security = {
		sudo.wheelNeedsPassword = false;
		rtkit.enable = true;
		polkit.enable = true;
	};
	security.wrappers.nekobox = {
		owner = "root";
		group = "root";
		capabilities = "cap_net_admin,cap_net_bind_service=+ep";
		source = "${pkgs.nekobox-bin}/bin/nekobox";
	};
}
