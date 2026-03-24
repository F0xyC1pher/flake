{
  # config,
  # lib,
  inputs,
  vars,
  ...
}:
{
  home-manager = {
    extraSpecialArgs = { inherit inputs vars; };
    users.${vars.userName} =
      {
        ...
      }:
      {
        xdg.configFile."niri/colors.kdl".text = ''
layout {
    /-border {
        // off
        // width 64
        // active-color "red"
    }

    /-focus-ring {
        // active-color "white"
    }
}

// layout {}
        '';
      };
  };
}
