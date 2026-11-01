{vars, ...}: {
  hjem.users.${vars.user.name}.xdg.config.files = {
    "hypr/05-misc.lua".text = /* lua */ ''
      hl.config({
      	misc = {
      		force_default_wallpaper = 0,    -- Set to 0 or 1 to disable the anime mascot wallpapers
      		disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background. :(
          disable_splash_rendering = true,
          float_force_onscreen = 2,
      		new_float_force_onscreen = 2,
      		focus_on_activate = false,
          on_focus_under_fullscreen = 0,
      	},
      })
    '';
  };
}
