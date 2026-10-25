{vars, ...}: {
  hjem.users.${vars.user.name}.xdg.config.files = {
    "waybar/modules/battery.json".text = ''
      // syntax: json
      {
      	"battery": {
      		"format": "{icon} {capacity}%",
      		"format-alt": "{icon} {time}",
      		"format-charging": "󰂅 {capacity}%",
      		"format-icons": ["󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"],
      		"states": {
      			"critical": 15,
      			"warning": 30,
      		},
      	},
      }
    '';
  };
}
