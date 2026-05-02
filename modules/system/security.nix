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
		source = "${pkgs.nekobox}/bin/nekobox";
	};
	security.pam.loginLimits = [
		{
			domain = "*";
			type = "soft";
			item = "nofile";
			value = "1048576";
		}
		{
			domain = "*";
			type = "hard";
			item = "nofile";
			value = "1048576";
		}
		{
			domain = "*";
			type = "soft";
			item = "nice";
			value = "-20";
		}
	];
}
