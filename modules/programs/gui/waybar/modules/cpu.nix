{vars, ...}: {
  hjem.users.${vars.user.name}.xdg.config.files = {
    "waybar/modules/cpu.json".text = ''
      // syntax: json
      {
      	"cpu": {
      		"interval": 5,
      		"format": " {load:.0f}%",
      		"on-click": "kitty btop",
      	},
      }
    '';
  };
}
