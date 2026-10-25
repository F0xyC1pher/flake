{vars, ...}: {
  hjem.users.${vars.user.name}.xdg.config.files = {
    "waybar/modules/backlight.json".text = ''
      // syntax: json
      {
      	"backlight": {
      		"device": "intel_backlight",
      		"format": "{icon} {percent}%",
      		"format-icons": [" ", " "],
      	},
      }
    '';
  };
}
