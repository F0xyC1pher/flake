{ stdenv, config, pkgs, lib, inputs, vars, ... }:
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
	i18n.supportedLocales = ["all"];
	
	# ========== NETWORK ==========
	time.timeZone = "Europe/Moscow";
	networking = {
		hostName = "${vars.hostName}";
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
	users.users.${vars.userName} = {
		isNormalUser = true;
		description = "${vars.userLongName}";
		home = "/home/${vars.userName}";
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
		dbus.enable = true;
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
		
		# mpd = {
		# 	enable = true;
		# 	musicDirectory = "/home/${vars.userName}/CoolStuff/Music";
		# 	user = "${vars.userName}";
		# 	settings = {
		# 		# Вот как теперь задаётся audio_output (это список, можно несколько блоков)
		# 		audio_output = [
		# 			{
		# 				type = "pipewire";
		# 				name = "My PipeWire Output";
		# 				# Дополнительные параметры, если нужно (опционально):
		# 				# format = "44100:16:2";      # пример
		# 				# mixer_type = "software";
		# 				# auto_resample = "no";
		# 			}
		# 		];
		# 		# Если нужны другие простые параметры (не блоки), пиши их прямо здесь:
		# 		# restore_paused = "yes";
		# 		# max_playlist_length = "16384";
		# 	};
		# 	# network = {
		# 	#     listenAddress = "any";          # если хочешь разрешить подключения не только с localhost
		# 	#     startWhenNeeded = true;         # systemd socket activation — очень удобно
		# 	#   };
		# 	# Optional:
		# #	network.listenAddress = "any"; # if you want to allow non-localhost connections
		# 	startWhenNeeded = true; # systemd feature: only start MPD service upon connection to its socket
		# };
		
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
	
	# Важно: Mopidy как system service → PipeWire как user service
	# Даём доступ к PipeWire сокету (uid 1000 = обычно первый юзер)
	# systemd.services.mopidy = {
	# 	environment = {
	# 		XDG_RUNTIME_DIR = "/run/user/1000";  # ← подставь правильный uid (id -u ${vars.userName})
	# 		PULSE_RUNTIME_PATH = "/run/user/1000/pulse";
	# 	};
	# 	serviceConfig = {
	# 		# Дополнительно: если не поможет, добавь
	# 		# SupplementaryGroups = [ "audio" "pipewire" ];  # иногда нужно
	# 		Restart = "always";
	# 	};
	# };
	
	# systemd.services.mpd.environment = {
	# 	# https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
	# 	XDG_RUNTIME_DIR = "/run/user/1000"; # User-id 1000 must match above user. MPD will look inside this directory for the PipeWire socket.
	# };
	
	# systemd.user.services.niri-flake-polkit.enable = false;
	# ========== FONTS ==========
	fonts = {
		packages = with pkgs; [
			monocraft
			minecraftia
			nerd-fonts.departure-mono
			nerd-fonts.fira-code
			fira-code-symbols
			font-awesome
			noto-fonts
			noto-fonts-color-emoji
		];
		
		fontconfig = {
			enable = true;
			cache32Bit = true;
			antialias = true;
			allowBitmaps = true;
			useEmbeddedBitmaps = true;
			subpixel = {
				rgba = "rgb";
				lcdfilter = "default";	
			};
			hinting = {
				enable = true;
				style = "slight";
				autohint = false;
			};
		};
	};
	
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
		
		hyprland = {
			enable = true;
			xwayland.enable = true;
			withUWSM = false;
			package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
		};
		
		uwsm.enable = true;
		
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
		
		neovim = {
			enable = true;
			# configure = {
				# packages.myVimPackage = with pkgs.vimPlugins; {
				# 	start = [ ctrlp ];
				# };
			# };
		};
		
		firefox = {
			enable = true;
			preferences = let ffVersion = config.programs.firefox.package.version; in {
				"media.ffmpeg.vaapi.enabled" = true;
				"media.hardware-video-decoding.force-enabled" = true;
				"media.rdd-ffmpeg.enabled" = lib.versionOlder ffVersion "97.0.0";
				
				"gfx.x11-egl.force-enabled" = true;
				"widget.dmabuf.force-enabled" = true;
				
				# Set this to true if your GPU supports AV1.
				#
				# This can be determined by reading the output of the
				# `vainfo` command, after the driver is enabled with
				# the environment variable.
				"media.av1.enabled" = true;
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
	
	# ==========	ENVIRONMENT	==========
	environment = {
		# ==========	PACKAGES	==========

		
		
		# ==========	VARIABLES	==========
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
	
	# stylix = {
	# 	enable = true;
	# 	
	# 	polarity = "dark";
	# 	
	# 	homeManagerIntegration = {
	# 		autoImport = true;
	# 		followSystem = true;
	# 	};
	# 	
	# 	targets = {
	# 		qt ={
	# 			enable = true;
	# 			platform = "qtct";
	# 			# standardDialogs = "xdgdesktopportal";
	# 			# style = "kvantum";
	# 		};
	# 	};
	# 	
	# 	opacity.terminal = 0.8;
	# 	
	# 	fonts = {
	# 		sizes.applications = 11;
	# 		sizes.desktop = 11;
	# 		sizes.terminal = 11;
	# 		serif.name = "FiraCode Nerd Font Mono";
	# 		monospace = config.stylix.fonts.serif;
	# 		sansSerif = config.stylix.fonts.serif;
	# 		emoji.name = "Noto Color Emoji";
	# 	};
	# 	
	# 	base16Scheme = {
	# 		# Фоны и основные поверхности
	# 		base00	=	"#060606";	# основной фон (editor, терминал, панели, tmux)
	# 		base01	=	"#363636";	# лёгкий фон (статус-бары, tabline, folded код, вторичные панели)
	# 		base02	=	"#565656";	# фон выделения текста (visual mode, selected text, поиск)
	# 		
	# 		# Серые тона для текста и неактивных элементов
	# 		base03	=	"#767676";	# комментарии, невидимые символы, cursorline, неактивные элементы
	# 		base04	=	"#a6a6a6";	# вторичный/приглушённый текст (statusline, git branch, метки, бордеры)
	# 		
	# 		# Основной и яркий текст
	# 		base05	=	"#d6d6d6";	# основной цвет текста (обычный код, prompt в терминале)
	# 		base06	=	"#f6f6f6";	# bright foreground / special UI
	# 		base07	=	"#f6f6f6";	# самый яркий белый (контрастный текст, bold/bright)
	# 		
	# 		# Акцентные цвета — семантика
	# 		base08	=	"#d76667";	# красный — ошибки, удалённое в diff, переменные, XML-теги, предупреждения
	# 		base09	=	"#ff6d66";	# оранжевый — числа, константы, escape-последовательности, пути/URL
	# 		base0A	=	"#fed666";	# жёлтый — классы, структуры, background поиска, WARN, иногда bold
	# 		base0B	=	"#67b766";	# зелёный — строки, добавленное в diff, успех
	# 		base0C	=	"#61d6d6";	# циан — типы, специальные конструкции, info, escape в строках
	# 		base0D	=	"#0666ff";	# синий — функции, методы, ссылки, основной акцентный цвет
	# 		base0E	=	"#a666fd";	# фиолетовый — ключевые слова, control flow, операторы, storage
	# 		base0F	=	"#fd66a6";	# пурпурный — deprecated, теги, вставки другого языка, спец-символы
	# 		
	# 		Scheme	=	"the-Me";
	# 		slug	=	"the-Me";
	# 		author	=	"FoxyChipher";
	# 	};
	# };
	
	system.stateVersion = "25.05";
}
