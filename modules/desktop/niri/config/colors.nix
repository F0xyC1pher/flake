{
  inputs,
  vars,
  ...
}:
{
  home-manager = {
    extraSpecialArgs = { inherit inputs vars; };
    users.${vars.user.name} =
      { ... }:
      let
        t = vars.theme.style;
      in
      {
        xdg.configFile."niri/colors.kdl".text = ''
          // syntax: kdl

          layout {
            background-color "transparent"

            focus-ring {
              active-color   "${t.accent}"
              inactive-color "#969696"
              urgent-color   "#b676f6"
            }

            border {
              active-color   "${t.ui.border.active}"
              inactive-color "${t.ui.border.inactive}"
              urgent-color   "#b676f6"
            }

            shadow {
              color "#00000076"
            }

            tab-indicator {
              active-color   "${t.accent}"
              inactive-color "#969696"
              urgent-color   "#b676f6"
            }

            insert-hint {
              color "${t.accent}76"
            }
          }

          recent-windows {
            highlight {
              active-color   "${t.accent}"
              urgent-color   "#b676f6"
            }
          }
        '';
      };
  };
}
