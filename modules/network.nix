{ stdenv, config, pkgs, lib, inputs, vars, ... }:
{
	# ========== NETWORK ==========
	networking = {
		hostName = "${vars.hostName}";
		networkmanager = {
			enable = true;
			dns = "none";
		};
		useDHCP = false;
		firewall.enable = false;
		nameservers = [
			"1.1.1.1"
			"1.0.0.1"
		];
		# hosts = {
		# 	"94.131.119.22" = [ "grok.com" "x.ai" "accounts.x.ai" ];
		# };
		wireless = {
			enable = true;
			userControlled = true;
		};
	};
}
