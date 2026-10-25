{vars, ...}: let
  outCfg = vars.host.hardware.audio.output;
  rateStr = toString outCfg.rate.value;

  # Числовые значения для карты квантов
  quantumMap = {
    "44100" = 512;
    "48000" = 512;
    "88200" = 1024;
    "96000" = 1024;
    "176400" = 2048;
    "192000" = 2048;
  };

  quantum = quantumMap.${rateStr} or 1024;
in {
  environment.sessionVariables = {
    # === Терминал ===
    # TERMINAL = "kitty";
    # TERMCMD = "kitty";

    # === Редакторы ===
    EDITOR = "micro";
    SUDO_EDITOR = "micro";
    VISUAL = "zeditor";

    # === Kitty ===
    KITTY_ENABLE_WAYLAND = "1";

    # === Micro ===
    MICRO_TRUECOLOR = "1";

    # === Qt ===
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_QPA_PLATFORMTHEME = "qt6ct";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";

    # === GTK / GDK ===
    NO_AT_BRIDGE = "1";
    GTK_A11Y = "none";
    GTK_USE_PORTAL = "1";
    GDK_DEBUG = "portals";
    GDK_BACKEND = "wayland,x11,*";

    # === Clutter ===
    CLUTTER_BACKEND = "wayland";

    # === Electron / Chromium ===
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";

    # === Firefox ===
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_DISABLE_RDD_SANDBOX = "1";

    # === SDL ===
    SDL_VIDEODRIVER = "wayland,x11,windows,*";
    SDL_VIDEO_WAYLAND_SCALE_TO_DISPLAY = "1";
    SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS = "0";

    # === Wine / Proton ===
    PROTON_ENABLE_WAYLAND = "1";
    PROTON_USE_NTSYNC = "1";
    PROTON_FORCE_LARGE_ADDRESS_AWARE = "1";
    PROTON_HIDE_NVIDIA_GPU = "0";
    PROTON_ENABLE_NVAPI = "1";
    PROTON_LOCAL_SHADER_CACHE = "1";

    # === Java ===
    _JAVA_AWT_WM_NONREPARENTING = "1";
    _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd";

    # === NVIDIA ===
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
    VDPAU_DRIVER = "nvidia";

    # === GStreamer (NVIDIA декодеры) ===
    GST_PLUGIN_FEATURE_RANK = "nvmpegvideodec:MAX,nvmpeg2videodec:MAX,nvmpeg4videodec:MAX,nvh264sldec:MAX,nvh264dec:MAX,nvjpegdec:MAX,nvh265sldec:MAX,nvh265dec:MAX,nvvp9dec:MAX";

    # === Отключение VSync глобально ===
    __GL_SYNC_TO_VBLANK = "0";
    __GL_YIELD = "NOTHING";
    __GL_GSYNC_ALLOWED = "0";
    __GL_VRR_ALLOWED = "0";
    vblank_mode = "0";

    # === Остальные NVIDIA/OpenGL оптимизации ===
    __GL_SHADER_DISK_CACHE = "1";
    __GL_ALLOW_UNOFFICIAL_PROTOCOL = "1";

    # === Дополнительно ===
    DXVK_ENABLE_NVAPI = "1";
    GLFW_IM_MODULE = "none";

    # Pipewire Латентность
    PIPEWIRE_LATENCY = "${toString quantum}/${rateStr}";

    # Telegram Desktop
    TDESKTOP_USE_GTK_FILE_DIALOG = "1";
    TDESKTOP_I_KNOW_ABOUT_GTK_INCOMPATIBILITY = "1";

    WEBKIT_DISABLE_DMABUF_RENDERER = "0";

    XCURSOR_THEME = vars.theme.cursor.name;
    XCURSOR_SIZE = toString vars.theme.cursor.size;
    HYPRCURSOR_THEME = vars.theme.cursor.name;
    HYPRCURSOR_SIZE = toString vars.theme.cursor.size;
  };
}
