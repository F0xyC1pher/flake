#./users/f/default.nix
{...}: {
  theme = {
    name = "the-me";
    accentLevel = "normal"; # "dimmed" | "normal" | "bright"
    accentColor = "purple"; # "red" | "orange" | "yellow" | "green" | "cyan" | "blue" | "purple" | "magenta"

    gaps = {
      "in" = 5;
      "out" = 5;
    };
    struts = {
      top = 0;
      bottom = 0;
      left = 10;
      right = 10;
    };
    # opacity = 0.666;
    opacity = 1;
    liquid-glass.enable = false;
    shadows = {
      enable = false;
      neon = false;
    };
    blur = {
      enable = false;
      xray.enable = false;
      settings = {
        passes = 2;
        offset = 2;
        noise = 0.05;
        saturation = 1.0;
      };
    };
    border = {
      size = 2;
      radius = 0;
    };
    font = {
      name = "Cascadia Code";
      # name = "Cozette";
      # name = "Iosevka";
      # name = "FiraCode";
      # name = "Monocraft";
      size = 12;
    };
    cursor = {
      name = "Posy_Cursor_Black";
      size = 24;
    };
  };
  app = {
    terminal = "kitty";
    launcher = "rofi";
    file-manager = {
      tui = "yazi";
      gui = null;
    };
    browser = {
      gui = "firefox";
      tui = "lyx";
    };
    text-editor = {
      gui = "zeditor";
      tui = "micro";
    };
  };
  user = {
    fullName = "F0xy_C1pher";
    mail = "ageev-eldar@mail.ru";
    gitName = "F0xy_C1pher";
    gitToken = "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";
    password = "$6$AntMCBLfJ4foukEM$UrkX24HXtg4oUToaOv6YNzoTigCoYX9CbbyY0pNRk6ZmVG/3StBux6gDWA1dWSIE490PF4Q/YFcVixA7gc8zy.";
    shell = "zsh"; # fish zsh bash
  };
  system = {
    modKey = "Super"; # Super Mod4
    desktopShell = "custom"; # custom dms noctalia
  };
  programs = [
    "nix-your-shell"
    "micro"
    "nh"
    "git"
    "fish"
    "zsh"
    "gtk"
    "qt"
    "dconf"
    "xwayland"
    "kitty"
    "fonts" # вообще он должен быть всегда
    "cursor" # вообще он должен быть всегда импортирован если есть окружение, типа он всегда нужен если ты не в tty
    "appimage"
    "no-gnome"
    "niri"
    "hyprland"
    # "scroll"
    # "shojiwm"
    # "umbriel"
    # "noctalia"
    # "dms"
    "waybar"
    # "fuzzel"
    "rofi"
    "yazi"
    "bat"
    "firefox"
    "zed-editor"
    "fastfetch"
    "uwsm"
    "throne"
    "swaylock"
    "nixvim"
    "mpv"
    "obs-studio"
    "rmpc"
    "tmux"
    # "skwd-wall"
    "gayming"
    # "dusk"
  ];
  services = [
    "tuigreet"
    "rofi-polkit-service"
    "accounts-daemon"
    "arrpc"
    "awww"
    "cliphist"
    "no-cups"
    "dbus"
    "dropbox"
    "earlyloom"
    "flatpak"
    "gvfs"
    "irqbalance"
    "locate"
    "mpd"
    "openssh"
    "pipewire"
    "playerctld"
    "resolved"
    "scx-loader"
    "seatd"
    # "sing-box"
    "swayidle"
    "swaync"
    # "tlp"
    "udev"
    # "upower"
    "userborn"
    "wl-clip-persist"
    # "xray-client"
    "xserver"
  ];
  packages = [
    "base"
    # "creamlinux"
    # "google-antigravity"
    "jdk"
    # "neu-nix"
    "session-packages"
    "wine"
    "r2modman-tui"
  ];
}
