{ stdenv, config, pkgs, lib, inputs, ... }:
{
	# ========== NIXPKGS ==========
	nixpkgs = {
		overlays = [ inputs.niri.overlays.niri ];
		config = {
			allowUnfree = true;
			permittedInsecurePackages = [
				"openssl-1.1.1w"
			];
		};
	};
	
	# ========== NIX ==========
	nix = {
		package = pkgs.lix;
		settings = {
			experimental-features = [ "nix-command" "flakes" ];

			substituters = [
				"https://cache.nixos.org/"
				# "https://cache.garnix.io"
			];
			trusted-public-keys = [
				"cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
				# "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
			];
		};
	};
	
	# ========== NVIDIA ==========
	hardware = {
		graphics = {
			enable = true;
			enable32Bit = true;
		};
		nvidia = {
			package = config.boot.kernelPackages.nvidiaPackages.stable;
			powerManagement.finegrained = false;
			powerManagement.enable = false;
			modesetting.enable = true;
			nvidiaSettings = true;
			open = false;
		};
	};
	# ========== BOOTLOADER ==========
	boot = {
		kernelPackages = pkgs.linuxPackages_xanmod_latest;
		extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
		blacklistedKernelModules = [ "nouveau" ];
		initrd.kernelModules = [ "nvidia" ];
		loader.grub = {
			enable = true;
			device = "/dev/sda";
		};
	};
	

	# ========== LOCALE ==========
	console = {
		font = "${pkgs.terminus_font}/share/consolefonts/ter-v14n.psf.gz";
		packages = with pkgs; [ terminus_font ];
		useXkbConfig = true;
		earlySetup = true;
		# keyMap = "ru";
	};
	i18n.defaultLocale = "ru_RU.UTF-8";

	
	# ========== NETWORK ==========
	time.timeZone = "Europe/Moscow";
	networking = {
		hostName = "p";
		networkmanager = {
			enable = true;
			dns = "none";
		};
		useDHCP = false;
	    firewall.enable = false;
		nameservers = [
			"1.1.1.1"
			"1.0.0.1"
		];
		hosts = {
			"94.131.119.22" = [ "grok.com" "x.ai" "accounts.x.ai" ];
		};
	};
	
	# ========== USER ==========
	users.users.f = {
		isNormalUser = true;
		description = "Foxy_Chipher";
		home = "/home/f";
		shell = pkgs.fish;
		extraGroups = [
			"networkmanager"
			"wheel"
			"video"
			"audio"
			"input"
			"rtkit"
			"render"
		];
	};
	security = {
		sudo.wheelNeedsPassword = false;
		rtkit.enable = true;
		polkit.enable = true;
	};
	
	# ========== SERVICES ==========
	services = {
		gnome.gnome-keyring.enable = lib.mkForce false;
		desktopManager.gnome.enable = lib.mkForce false;
		pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
			jack.enable = true;
			wireplumber.enable = true;
		};
		xserver = {
			enable = true;
			videoDrivers = ["nvidia"];
			xkb.layout = "us,ru";
			xkb.options = "grp:lalt_lshift_toggle;";
			xkb.model = "pc86";
		};
		greetd = {
			enable = true;
			useTextGreeter = true;
			settings = {
				default_session = {
					command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --xsessions ${config.services.displayManager.sessionData.desktops}/share/xsessions --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions";
					user = "greeter";
				};
			};
		};
	};

	
	
	# systemd.user.services.niri-flake-polkit.enable = false;
	# ========== FONTS ==========
	fonts.packages = with pkgs; [
		nerd-fonts.fira-code
		font-awesome
		noto-fonts
		noto-fonts-color-emoji
	];
	
	# ========== XDG PORTAL ==========
	xdg = {
		mime.enable = true;
		mime.defaultApplications = { "inode/directory" = "yazi.desktop"; };
		portal = {
			enable = true;
			wlr.enable = true;
			xdgOpenUsePortal = true;
			extraPortals = lib.mkForce [
				pkgs.xdg-desktop-portal-termfilechooser
			];
			config = {
				common = lib.mkForce {
					"org.freedesktop.impl.portal.FileChooser" = ["termfilechooser" "xdg-desktop-portal-termfilechooser"];
					"org.freedesktop.impl.portal.ScreenCast" = "wlr";
					"org.freedesktop.impl.portal.Screenshot" = "wlr";
					default = ["termfilechooser" "xdg-desktop-portal-termfilechooser"];	
				};
				niri = lib.mkForce {
					"org.freedesktop.impl.portal.FileChooser" = ["termfilechooser" "xdg-desktop-portal-termfilechooser"];
					"org.freedesktop.impl.portal.ScreenCast" = "wlr";
					"org.freedesktop.impl.portal.Screenshot" = "wlr";
					default = ["termfilechooser" "xdg-desktop-portal-termfilechooser"];	
				};
			};			
			configPackages = lib.mkForce [
				pkgs.xdg-desktop-portal-termfilechooser
			];
		};
		terminal-exec = {
			enable = true;
			settings = {
				default = [
					"kitty.desktop"
				];
			};
		};
	};
	# xdg.portal.enable = true;
	# xdg.portal.extraPortals = [
	    # pkgs.xdg-desktop-portal-termfilechooser
	  # ];
	# xdg.portal.config.common."org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
	
	# ========== PROGRAMS ==========
	programs = {
		fish.enable = true;
		bash.enable = true;

		niri = {
			enable = true;
			package = pkgs.niri-unstable;
		};
		mango = {
			enable = true;
		};

		steam = {
			enable = true;
			remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remoteplay
			dedicatedServer.openFirewall = true; # Open ports in the firewall for steam server
			gamescopeSession.enable = true;
			extraCompatPackages = with pkgs; [
				proton-ge-bin
				gamemode
			];
		};

		firefox = {
			enable = true;
			preferences = let ffVersion = config.programs.firefox.package.version; in {
				"media.ffmpeg.vaapi.enabled" = lib.versionOlder ffVersion "137.0.0";
				"media.hardware-video-decoding.force-enabled" = lib.versionAtLeast ffVersion "137.0.0";
				"media.rdd-ffmpeg.enabled" = lib.versionOlder ffVersion "97.0.0";

				"gfx.x11-egl.force-enabled" = true;
				"widget.dmabuf.force-enabled" = true;

				# Set this to true if your GPU supports AV1.
				#
				# This can be determined by reading the output of the
				# `vainfo` command, after the driver is enabled with
				# the environment variable.
				# "media.av1.enabled" = false;
			};
		};

		gamemode.enable = true;
		
		waybar = {
			enable = true;
		};
		
		throne = {
			enable = true;
			tunMode.enable = true;
		};

		obs-studio = {
			enable = true;
			enableVirtualCamera = true;
		};
		
		yazi = {
			enable = true;
			plugins = {
			inherit (pkgs.yaziPlugins) sudo;
			inherit (pkgs.yaziPlugins) glow;
			inherit (pkgs.yaziPlugins) piper;
			inherit (pkgs.yaziPlugins) mount;
			inherit (pkgs.yaziPlugins) gitui;
			inherit (pkgs.yaziPlugins) chmod;
			inherit (pkgs.yaziPlugins) miller;
			inherit (pkgs.yaziPlugins) yatline;
			inherit (pkgs.yaziPlugins) mime-ext;
			inherit (pkgs.yaziPlugins) compress;
			inherit (pkgs.yaziPlugins) mediainfo;
			inherit (pkgs.yaziPlugins) toggle-pane;
			inherit (pkgs.yaziPlugins) full-border;
			# inherit (pkgs.yaziPlugins) ;
			};
		};
		appimage.enable = true;
		appimage.binfmt = true;
		
	};
	
	# ========== PACKAGES ==========
	environment.systemPackages = with pkgs; [
	    inputs.freesmlauncher.packages.${pkgs.system}.freesmlauncher
		ayugram-desktop
		nixd
		nil
		package-version-server
	    zenity
		kitty
		ntfs3g
		android-tools
		mangohud
		git
		micro-full
		sublime4
		vscodium
		swww
		fzf
		wget
		btop
		discord
		discordo
		discord-gamesdk
		discord-rpc
		# ripcord
		# overlayed
		# goofcord
		arrpc
		# mpvScripts.mpv-discord
		moonlight
		vesktop
		# mprisence
		# abaddon
		# legcord
		# equicord
		babelfish
		ffmpeg-full
	    imagemagick
	    pandoc
	    yt-dlp
	    mpv
	    eza
        bat
        fd
        zed-editor
        socat
	    ripgrep-all
		pavucontrol
		fastfetch
		wl-clipboard
		wl-clipboard-x11
		wl-clip-persist
		cliphist
		wayland-utils
		xwayland-satellite-unstable
		keepassxc
		git-credential-keepassxc
		# xdg-desktop-portal-gtk
		# xdg-desktop-portal-wlr
		# xdg-desktop-portal-termfilechooser
		# rofi-polkit-agent
		cmd-polkit 
		jq
		rofi
		swaylock
		swaynotificationcenter
		mpd
		mpdris2
		rmpc
		obsidian
		libva-vdpau-driver
		libvdpau-va-gl
		obs-studio-plugins.obs-vaapi
		nvidia-vaapi-driver
		cmd-polkit
		tuigreet
		niri-unstable
		helix
	];

	
	# ========== ENVIRONMENT VARS ==========
	environment.sessionVariables = lib.mkForce {
		# Базовые Wayland настройки
		# XDG_SESSION_TYPE = "wayland";
		# XDG_SESSION_DESKTOP = "niri";
		# XDG_CURRENT_DESKTOP = "niri";

		# Терминал и редакторы
		# TERMINAL = "kitty";
		# EDITOR = "micro";
		# SUDO_EDITOR = "micro";
		# VISUAL = "subl";

		# Kitty
		KITTY_ENABLE_WAYLAND = "1";

		# Qt
		QT_QPA_PLATFORM = "wayland;xcb";
		# QT_QPA_PLATFORMTHEME = "qt6ct";
		# QT_QPA_PLATFORMTHEME_QT6 = "qt6ct";
		
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
	

	system.stateVersion = "25.05";
}
