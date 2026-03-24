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
        xdg.configFile."niri/layout.kdl".text = ''
layout {
    // Set gaps around windows in logical pixels.
    gaps 50
    background-color "transparent"
    // When to center a column when changing focus, options are:
    // - "never", default behavior, focusing an off-screen column will keep at the left
    //   or right edge of the screen.
    // - "always", the focused column will always be centered.
    // - "on-overflow", focusing a column will center it if it doesn't fit
    //   together with the previously focused column.
    center-focused-column "never"

    // You can customize the widths that "switch-preset-column-width" (Mod+R) toggles between.
    preset-column-widths {
        // Proportion sets the width as a fraction of the output width, taking gaps into account.
        // For example, you can perfectly fit four windows sized "proportion 0.25" on an output.
        // The default preset widths are 1/3, 1/2 and 2/3 of the output.
        proportion 0.33333
        proportion 0.5
        proportion 0.66667

        // Fixed sets the width in logical pixels exactly.
        // fixed 1920
    }

    // You can also customize the heights that "switch-preset-window-height" (Mod+Shift+R) toggles between.
    // preset-window-heights { }

    // You can change the default width of the new windows.
    default-column-width { proportion 0.5; }
    // If you leave the brackets empty, the windows themselves will decide their initial width.
    // default-column-width {}

    focus-ring {
    // off
     width 4
        active-color "#d76667"
        inactive-color "#363636"
       
    }

    // You can also add a border. It's similar to the focus ring, but always visible.
    border {
        off
        width 4
        active-color "#d76667"
        inactive-color "#363636"
        urgent-color "#9b0000"
        // Gradients can use a few different interpolation color spaces.
        // For example, this is a pastel rainbow gradient via in="oklch longer hue".
        //
        // active-gradient from="#e5989b" to="#ffb4a2" angle=45 relative-to="workspace-view" in="oklch longer hue"

        // inactive-gradient from="#505050" to="#808080" angle=45 relative-to="workspace-view"
    }

    // You can enable drop shadows for windows.
    shadow {
        // Uncomment the next line to enable shadows.
        on
        draw-behind-window false
        // You can change how shadows look. The values below are in logical
        // pixels and match the CSS box-shadow properties.
        // Softness controls the shadow blur radius.
        softness 40
        // Spread expands the shadow.
        spread 10
        // Offset moves the shadow relative to the window.
        offset x=0 y=0
        // You can also change the shadow color and opacity.
        color "#2f2f2f"
    }

    // Struts shrink the area occupied by windows, similarly to layer-shell panels.
    // You can think of them as a kind of outer gaps. They are set in logical pixels.
    // Left and right struts will cause the next window to the side to always be visible.
    // Top and bottom struts will simply add outer gaps in addition to the area occupied by
    // layer-shell panels and regular gaps.
    struts {
         left 10
         right 10
         top -10
         bottom -10
    }
}
        '';
      };
  };
}
