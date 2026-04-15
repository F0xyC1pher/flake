{...}: {
	services.tailscale.enable = true;
	services.tailscale.useRoutingFeatures = "both";
	systemd.services.tailscaled.serviceConfig.Environment = [
		"TS_DEBUG_FIREWALL_MODE=nftables"
	];
}
