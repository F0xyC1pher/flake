{vars, ...}: {
  hjem.users.${vars.user.name}.xdg.config.files = {
    "waybar/modules/custom/arrow-left.json".text = ''
      // syntax: json
      {
      	"custom/arrow-left": {
      		"format": "",
      		"tooltip": false,
      		"cursor": true,
      	},
      }
    '';
  };
}
