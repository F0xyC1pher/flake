{vars, ...}: {
  hjem.users.${vars.user.name} = {
    xdg.config.files."niri/colors.kdl".text = let
      t = vars.theme.style;
    in ''
      // syntax: kdl

      layout {
      	background-color "transparent"

      	focus-ring {
      		active-color   "${t.ui.border.active}"
      		inactive-color "${t.ui.border.inactive}${vars.theme.opacityHex}"
      		urgent-color   "#b676f6"
      	}

      	border {
      		active-color   "${t.ui.border.active}"
      		inactive-color "${t.ui.border.inactive}${vars.theme.opacityHex}"
      		urgent-color   "#b676f6"
      	}

      	shadow {
      	color "${vars.theme.style.ui.bg}${vars.theme.opacityHex}"
      	}

      	tab-indicator {
      		active-color   "${t.accent}"
      		inactive-color "#969696${vars.theme.opacityHex}"
      		urgent-color   "#b676f6"
      	}

      	insert-hint {
      		color "${t.accent}${vars.theme.opacityHex}"
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
}
