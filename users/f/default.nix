{ ... }:
{
  theme = {
    name = "theMe";
    dark = true;
    # gaps = 8;
    # border = 2;

    # Optional — override raw palette values BEFORE the role mapping runs.
    # colorOverrides = {
    # 	accent.red = "#f67676";
    # };
    # Optional — override resolved role tree AFTER mapping. Highest priority.
    # roleOverrides = {
    # 	accent = "#f67676";
    # 	ui.border.active = "#f67676";

    # };

    font = {
      name = "Monocraft";
      size = 14;
    };

    blur = {
      enable = true;
      xray.enable = false;
    };
  };
  user = {
    fullName = "Foxy_Chipher";
    mail = "ageev-eldar@mail.ru";
    gitName = "FoxyChipher";
    password = "$6$AntMCBLfJ4foukEM$UrkX24HXtg4oUToaOv6YNzoTigCoYX9CbbyY0pNRk6ZmVG/3StBux6gDWA1dWSIE490PF4Q/YFcVixA7gc8zy.";
    shell = "fish"; # fish zsh bash brush
  };
  system = {
    modKey = "Mod4"; # Super
    desktopShell = "dms"; # custom dms noctalia
  };
  app = {
    gui = {
      browser = "firefox"; # firefox floorp zen ungoogled-chromium chrome
      file-manager = "yazi"; # nautilus nemo
      launcher = "fuzzel"; # fuzzel rofi
      text-editor = "vscodium"; # vscodium zed
    };
    terminal = "kitty";
    tui = {
      browser = "lyx"; # lyx
      file-manager = "yazi"; # yazi ranger
      # launcher = "fuzzel"; #fuzzel rofi
      text-editor = "micro"; # micro nano
    };
  };
}
