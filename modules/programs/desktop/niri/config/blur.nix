{vars, ...}: {
  hjem.users.${vars.user.name} = {
    xdg.config.files."niri/blur.kdl".text = ''
      // syntax: kdl
      blur {
      	passes ${toString vars.theme.blur.settings.passes}
      	offset ${toString vars.theme.blur.settings.offset}
      	noise ${toString vars.theme.blur.settings.noise}
      	saturation ${toString vars.theme.blur.settings.saturation}
      }
    '';
  };
}
