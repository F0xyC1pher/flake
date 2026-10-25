{vars, ...}: {
  hjem.users.${vars.user.name}.xdg.config.files = {
    "waybar/modules/network.json".text = ''
      // syntax: json
      {
      	"network": {
      		"interval": 5,
      		"format-wifi": "wi-fi ({signalStrength}%)",
      		"format-ethernet": "󰈀 eth",
      		"format-linked": "no IP ({ifname})",
      		"format-disconnected":"no",
      		"tooltip-format": "{ifname} {ipaddr}/{cidr} via {gwaddr} ↓{bandwidthDownBytes} ↑{bandwidthUpBytes}",
      		// "on-click-right": "~/.config/niri/scripts/networkmanager_dmenu",
      	},
      }
    '';
  };
}
