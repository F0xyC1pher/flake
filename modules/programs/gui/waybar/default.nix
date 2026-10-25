{vars, ...}: {
  imports = [
    ./modules
    ./style.nix
  ];
  programs.waybar.enable = true;
  hjem.users.${vars.user.name}.xdg.config.files = {
    "waybar/config".text = ''
      // syntax: json
      {
      	"include": [
      		"./modules/default.json"
      	],

      	"layer": "top",
      	"position": "top",
        "exclusive-zone": true,
      	"height": 30,
      	"spacing": 3,

      	"modules-left": [
      		"group/left-hidden",
      		"niri/language",
      	],

      	"modules-center": [
      		"custom/notification",
      		"niri/workspaces",
      	],

      	"modules-right": [
      		"group/right-hidden",
      		"clock",
      		"tray",
      	],
      }
    '';
  };
}
