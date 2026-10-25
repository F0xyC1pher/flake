{
  vars,
  lib,
  ...
}: {
  hjem.users.${vars.user.name}.xdg.config.files = {
    "waybar/modules/memory.json".text = ''
      // syntax: json
      {
      	"memory": {
      		"interval": 5,
      		"format": "󰍛 {}%",
      		"on-click": "${lib.optionalString (vars.app.launcher == "fuzzel") "cliphist-fuzzel-img"} ${lib.optionalString (vars.app.launcher == "rofi") "rofi -modi clipboard:cliphist-rofi-img -show clipboard -show-icons"}",
      	},
      }
    '';
  };
}
