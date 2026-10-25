{vars, ...}: {
  hjem.users.${vars.user.name}.xdg.config.files = {
    "waybar/modules/custom/arrow-right.json".text = ''
      // syntax: json
      {
      	"custom/arrow-right": {
      		"format": "",
      		"tooltip": false,
      		"cursor": true,
      	},
      }
    '';
  };
}
