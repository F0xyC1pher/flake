{vars, ...}: {
  hjem.users.${vars.user.name}.xdg.config.files = {
    "waybar/modules/disk.json".text = ''
      // syntax: json
      {
      	"disk": {
      	  "interval": 60,
      	  "path": "/",
      	  "format": " {percentage_used}%",
      	  "on-click": "kitty yazi",
      	  "tooltip-format": "{used} used out of {total} on {path} ({percentage_used}%)"
      	},
      }
    '';
  };
}
