{vars, ...}: {
  imports = [
    ./animations.nix
    ./binds.nix
    ./decorations.nix
    ./general.nix
    ./inputs.nix
    ./outputs.nix
    ./window-rules.nix
  ];
  hjem.users.${vars.user.name}.xdg.config.files = {
    "hypr/hyprland.lua".text = ''
      local hm_xdg_config_home = os.getenv("XDG_CONFIG_HOME") or "/home/f/.config"
      package.path = hm_xdg_config_home .. "/hypr/?.lua;" .. hm_xdg_config_home .. "/hypr/?/init.lua;" .. package.path
      require("00-animations")
      require("01-binds")
      require("02-decorations")
      require("03-general")
      require("04-inputs")
      require("06-outputs")
      require("07-window-rules")
    '';
  };
}
