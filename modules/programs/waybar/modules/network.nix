{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			xdg.configFile."waybar/modules/network.json".text = ''
				# json
				{
					network = {
						interval = 2;
						format-wifi = "{gwaddr} ({signalStrength}%)";
						format-ethernet = "{gwaddr}";
						format-linked = "No IP ({ifname})";
						format-disconnected = "Disconnected";
						# tooltip-format = "{ifname} {ipaddr}/{cidr} via {gwaddr}";
						# format-alt = "↓{bandwidthDownBytes} ↑{bandwidthUpBytes}";
						on-click-right = "~/.config/niri/scripts/networkmanager_dmenu";
					};
				}
			'';
		};
	};
}
