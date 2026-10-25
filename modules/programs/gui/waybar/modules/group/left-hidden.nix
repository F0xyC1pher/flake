{vars, ...}: {
  hjem.users.${vars.user.name}.xdg.config.files = {
    "waybar/modules/group/left-hidden.json".text = ''
      // syntax: json
      {
      	"group/left-hidden": {
      		"orientation": "horizontal",
      		"drawer": {
      			"transition-duration": 500,
      			"transition-left-to-right": true,
      			"click-to-reveal": true,
      		},
      		"modules": [
      			"custom/arrow-right",
      			"backlight",
      			"bluetooth",
      			"wireplumber",
      			"wireplumber#source",
      		],
      	},
      }
    '';
  };
}
