{vars, ...}: {
  hjem.users.${vars.user.name}.xdg.config.files = {
    "hypr/04-inputs.lua".text = ''
      hl.config({
        input = {
          kb_layout = "us,ru",
          kb_options = "grp:lalt_lshift_toggle",
          repeat_delay = 250,
          repeat_rate = 60,
      		mouse_refocus = true,
          follow_mouse = 1,
          accel_profile = "flat",
          touchpad = {
            natural_scroll = true,
            tap_to_click = true,
            drag_lock = true,
            tap_and_drag = true,
            clickfinger_behavior = false,
          },
        },
      })
    '';
  };
}
