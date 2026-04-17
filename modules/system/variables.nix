{...}: {
	environment.sessionVariables = {
		# === Wayland session ===
		XDG_SESSION_TYPE = "wayland";
		XDG_SESSION_DESKTOP = "niri";
		XDG_CURRENT_DESKTOP = "niri";

		# === Терминал ===
		TERMINAL = "kitty";
		TERMCMD = "kitty";
		TERM = "kitty-256color";

		# === Редакторы ===
		EDITOR = "micro";
		SUDO_EDITOR = "micro";
		VISUAL = "codium";

		# === Kitty ===
		KITTY_ENABLE_WAYLAND = "1";

		# === Qt ===
		QT_QPA_PLATFORM = "wayland;xcb";

		# === GTK / GDK ===
		NO_AT_BRIDGE = "1";
		GTK_A11Y = "none";
		GTK_USE_PORTAL = "1";
		GDK_DEBUG = "portals";
		GDK_BACKEND = "wayland,x11,*";

		# === Clutter ===
		CLUTTER_BACKEND = "wayland";

		# === NVIDIA ===
		GBM_BACKEND = "nvidia-drm";
		__GLX_VENDOR_LIBRARY_NAME = "nvidia";
		LIBVA_DRIVER_NAME = "nvidia";
		VDPAU_DRIVER = "nvidia";

		# === Electron / Chromium ===
		NIXOS_OZONE_WL = "1";
		ELECTRON_OZONE_PLATFORM_HINT = "wayland";

		# === Firefox ===
		MOZ_ENABLE_WAYLAND = "1";
		MOZ_DISABLE_RDD_SANDBOX = "1";

		# === SDL ===
		SDL_VIDEODRIVER = "wayland,x11";
		SDL_VIDEO_WAYLAND_SCALE_TO_DISPLAY = "1";
		SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS = "0";

		# === Java ===
		_JAVA_AWT_WM_NONREPARENTING = "1";

		# === GStreamer (NVIDIA декодеры) ===
		GST_PLUGIN_FEATURE_RANK = "nvmpegvideodec:MAX,nvmpeg2videodec:MAX,nvmpeg4videodec:MAX,nvh264sldec:MAX,nvh264dec:MAX,nvjpegdec:MAX,nvh265sldec:MAX,nvh265dec:MAX,nvvp9dec:MAX";

		# === Wine / Proton ===
		PROTON_ENABLE_WAYLAND = "1";
		PROTON_USE_NTSYNC = "1";
		PROTON_FORCE_LARGE_ADDRESS_AWARE = "1";
		PROTON_HIDE_NVIDIA_GPU = "0";

		# === MangoHud ===
		MANGOHUD = "1";
		MANGOHUD_DLSYM = "1";

		# === Отключение VSync глобально ===
		MESA_VK_WSI_PRESENT_MODE = "immediate";
		__GL_SYNC_TO_VBLANK = "0";
		__GL_YIELD = "NOTHING";
		__GL_GSYNC_ALLOWED = "0";
		__GL_VRR_ALLOWED = "0";
		__GL_MAX_FRAMES_ALLOWED = "0";
		vblank_mode = "0";

		# === Остальные NVIDIA/OpenGL оптимизации ===
		__GL_SHADER_CACHE = "1";
		__GL_SHADER_DISK_CACHE = "1";
		__GL_SHADER_DISK_CACHE_SKIP_CLEANUP = "0";
		__GL_ExperimentalPerfStrategy = "1";
		__GL_ConformantBlitFramebufferScissor = "1";

		# Старые/дополнительные NVIDIA переменные
		__GL_ALLOW_FXAA = "0";
		__GL_THREADED_OPTIMIZATIONS = "0";

		# === Дополнительно ===
		DXVK_SHADER_OPTIMIZE = "1";
		DXVK_ENABLE_NVAPI = "1";
		STAGING_SHARED_MEMORY = "1"; # Wine
		GLFW_IM_MODULE = "none";

		# Telegram Desktop
		TDESKTOP_USE_GTK_FILE_DIALOG = "1";
		TDESKTOP_I_KNOW_ABOUT_GTK_INCOMPATIBILITY = "1";
	};
}
