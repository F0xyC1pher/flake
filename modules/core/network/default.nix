{
	vars,
	config,
	...
}: {
	imports = [
		./dispatchers.nix
		./sing-box.nix
	];
	# ========== NETWORK ==========
	systemd.network.wait-online.enable = false;
	boot.initrd.systemd.network.wait-online.enable = false;
	networking = {
		nftables.enable = true;
		enableIPv6 = true;
		hostName = "${vars.host.name}";
		useDHCP = false;
		networkmanager = {
			enable = true;
			dns = "systemd-resolved";
			# dns = "none";
			# insertNameservers = ["127.0.0.1"];
			# insertNameservers = ["1.1.1.1"];
		};
		firewall = {
			enable = false;
		};
		wireless = {
			enable = vars.host.hardware.wifi.enable;
			userControlled = true;
		};
		# nameservers = [
		# 	"1.1.1.1#one.one.one.one"
		# 	"1.0.0.1#one.one.one.one"
		# ];

		# hosts = {
		# 	"94.131.119.22" = [ "grok.com" "x.ai" "accounts.x.ai" "gemini.google.com/app"];
		# };
	};
}
