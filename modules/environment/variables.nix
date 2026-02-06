{ lib, inputs, vars, ... }:
{
#	==========ENVIRONMENT==========
	environment = {
		
#		==========VARIABLES==========
		variables = lib.mkForce {
			# Базовые Wayland настройки
			# XDG_SESSION_TYPE = "wayland";
			# XDG_SESSION_DESKTOP = "niri";
			# XDG_CURRENT_DESKTOP = "niri";
			
			# Терминал и редакторы
			TERMINAL = "kitty";
			TERMCMD = "kitty";
			EDITOR = "micro";
			SUDO_EDITOR = "micro";
			VISUAL = "micro";
			
			# Kitty
			KITTY_ENABLE_WAYLAND = "1";
			
			# Qt
			QT_QPA_PLATFORM = "wayland;xcb";
			# QT_QPA_PLATFORMTHEME = "qt6ct";
			# QT_QPA_PLATFORMTHEME_QT6 = "qt6ct";
			# QT_STYLE_OVERRIDE = null;
			
			# GTK/ATK
			NO_AT_BRIDGE = "1";
			GTK_A11Y = "none";
			
			# GTK настройки
			# GTK_USE_IEC_UNITS = "1";
			# GTK_OVERLAY_SCROLLING = "1";
			GTK_USE_PORTAL = "1";
			GDK_DEBUG = "portals";
			
			# NVIDIA Wayland поддержка
			GBM_BACKEND = "nvidia-drm";
			__GLX_VENDOR_LIBRARY_NAME = "nvidia";
			
			# GDK/Clutter
			GDK_BACKEND = "wayland,x11,*";
			CLUTTER_BACKEND = "wayland";
			CLUTTER_DEFAULT_FPS = "60";
			
			# SDL
			SDL_VIDEODRIVER = "wayland,x11,windows";
			SDL_AUDIODRIVER= "pipewire";
			SDL_VIDEO_WAYLAND_SCALE_TO_DISPLAY = "1";
			SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS = "0";
			LD_BIND_NOW = "1";
			
			# Java
			_JAVA_AWT_WM_NONREPARENTING = "1";
			
			# Electron
			ELECTRON_OZONE_PLATFORM_HINT = "wayland";
			
			# NVIDIA кодеков
			GST_PLUGIN_PATH = "/run/current-system/sw/lib/gstreamer-1.0/";
			GST_PLUGIN_FEATURE_RANK = "nvmpegvideodec:MAX,nvmpeg2videodec:MAX,nvmpeg4videodec:MAX,nvh264sldec:MAX,nvh264dec:MAX,nvjpegdec:MAX,nvh265sldec:MAX,nvh265dec:MAX,nvvp9dec:MAX";
			GST_VAAPI_ALL_DRIVERS = "1";
			
			# VA-API/VDPAU
			LIBVA_DRIVER_NAME = "nvidia";
			VAAPI_MPEG4_ENABLED = "true";
			VDPAU_DRIVER = "nvidia";
			
			# Firefox
			MOZ_DISABLE_RDD_SANDBOX = "1";
			MOZ_ENABLE_WAYLAND = "1";
			# MOZ_X11_EGL = "1";
			
			# NVIDIA Direct Rendering
			NVD_BACKEND = "direct";
			
			# OBS Studio
			# OBS_USE_EGL = "1";
			
			# MangoHud
			MANGOHUD = "1";
			MANGOHUD_DLSYM = "1";
			
			# Wine
			# //WINEPREFIX = "$HOME/.wine";
			# //WINEARCH = "win64";
			STAGING_SHARED_MEMORY = "1";
			
			# NVIDIA OpenGL оптимизации
			__GL_SHADER_CACHE = "1";
			__GL_SHADER_DISK_CACHE = "1";
			__GL_SHADER_DISK_CACHE_SKIP_CLEANUP = "1";
			__GL_ExperimentalPerfStrategy = "1";
			__GL_ConformantBlitFramebufferScissor = "1";
			__GL_MaxFramesAllowed = "1";
			__GL_SYNC_TO_VBLANK = "0";
			__GL_YIELD = "NOTHING";
			
			# Ввод
			GLFW_IM_MODULE = "none";
			
			# Синхронизация/VSync
			mesa_glthread = "true";
			vblank_mode = "0";
			gl_vsync = "0";
			vsync = "1";
			
			# Vulkan
			MESA_VK_WSI_PRESENT_MODE = "immediate";
			
			# DXVK
			DXVK_SHADER_OPTIMIZE = "1";
			DXVK_ENABLE_NVAPI = "1";
			DXVK_ASYNC = "1";
			DXVK_FRAME_RATE = "60";
			DXVK_CONFIG = "dxgi.syncInterval=0; d3d9.presentInterval=0";
			
			# VkBasalt
			ENABLE_VKBASALT = "0";
			
			# Аудио
			PIPEWIRE_LATENCY = "512/48000";
			PULSE_LATENCY_MSEC = "60";
			
			# Proton
			PROTON_FORCE_LARGE_ADDRESS_AWARE = "1";
			PROTON_HIDE_NVIDIA_GPU = "0";
			PROTON_USE_NTSYNC = "1";
			# //PROTON_ENABLE_WAYLAND = "1";
			PROTON_LOG = "1";
			
			# Wayland/XWayland
			vk_xwayland_wait_ready = "false";
			
			# NixOS специфичные
			NIXOS_OZONE_WL = "1";
			
			# Telegram Desktop
			TDESKTOP_USE_GTK_FILE_DIALOG = "1";
			TDESKTOP_I_KNOW_ABOUT_GTK_INCOMPATIBILITY = "1";
		};
	};
}
