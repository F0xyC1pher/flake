{vars, ...}: {
  hjem.users.${vars.user.name}.xdg.config.files = {
    "waybar/modules/module.json".text = ''
      // syntax: json
      {
      	"some-text-variable":"some-value",
      	"some-digit-variable": 0,
      	"some-array-variable": [
      		"1",
      		"2",
      		"3",
      	],
      }
    '';
  };
}
