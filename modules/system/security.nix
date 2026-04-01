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
	security.pam.loginLimits = [
		{
			domain = "@audio";
			type = "soft";
			item = "rtprio";
			value = "98";
		}
		{
			domain = "@audio";
			type = "hard";
			item = "rtprio";
			value = "98";
		}
		{
			domain = "@audio";
			type = "soft";
			item = "memlock";
			value = "unlimited";
		}
		{
			domain = "@audio";
			type = "hard";
			item = "memlock";
			value = "unlimited";
		}
		{
			domain = "@audio";
			type = "soft";
			item = "nice";
			value = "-11";
		}
		{
			domain = "@audio";
			type = "hard";
			item = "nice";
			value = "-11";
		}
	];
}
