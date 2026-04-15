{...}: {
	services.tailscale.enable = true;
	services.tailscale.useRoutingFeatures = "both";
	services.tailscale.extraDaemonFlags = ["--no-logs-no-support"];
}
