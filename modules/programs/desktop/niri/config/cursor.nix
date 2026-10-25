{vars, ...}: {
  hjem.users.${vars.user.name} = {
    xdg.config.files."niri/cursor.kdl".text = ''
      // syntax: kdl
      cursor {
      	xcursor-theme "${vars.theme.cursor.name}"
      	xcursor-size ${toString vars.theme.cursor.size}
      }
    '';
  };
}
