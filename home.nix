{ lib, config, pkgs, inputs, ... }:
let
	nightdiamondCursors = pkgs.nightdiamond-cursors;
	rofi-polkit-script = pkgs.fetchurl {
	    url = "https://raw.githubusercontent.com/czaplicki/rofi-polkit-agent/master/rofi-polkit-agent";
	    sha256 = "1lv5m291v45akj7kh2z29sjk8hd36bdf5c1h7saxvl8dkr6jm00y";
	};
	
	rofi-polkit-agent = pkgs.writeShellScriptBin "rofi-polkit-agent" ''
	    #!/usr/bin/env bash
	    ${builtins.readFile rofi-polkit-script}
	  '';
	
in
{
	# ========== HOME ==========
	home.username = "f";
	home.homeDirectory = "/home/f";
	home.stateVersion = "25.05";

	home.packages = [
		rofi-polkit-agent
		pkgs.cmd-polkit  # ← обязательно!
		pkgs.jq
	];
	
	gtk = {
		enable = true;
	};
	
	home.pointerCursor = {
		gtk.enable = true;
		x11.enable = true;
		package = nightdiamondCursors;
		name = "NightDiamond-Red";
		size = 32;
	};


systemd.user.services.rofi-polkit-agent = {
    Unit = {
      Description = "Rofi-based Polkit Authentication Agent";
      After = [ "graphical-session.target" ];
      Wants = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "${rofi-polkit-agent}/bin/rofi-polkit-agent";
      Restart = "on-failure";
      RestartSec = 3;
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
	# ========== STYLIX ==========
	stylix = {
		enable = true;
		polarity = "dark";
		targets.qt.enable = true;
		targets.qt.platform = "qtct";
		targets.qt.standardDialogs = "xdgdesktopportal";
		opacity.terminal = 0.9;
		fonts = {
			sizes.applications = 10;
			sizes.desktop = 12;
			monospace =	{
				package = pkgs.nerd-fonts.fira-code;
				name = "FiraCode Nerd Font";
			};
			sansSerif = {
				package = pkgs.nerd-fonts.ubuntu;
				name = "Ubuntu Nerd Font";
			};
			serif = config.stylix.fonts.sansSerif;
			emoji = {
				package = pkgs.noto-fonts-color-emoji;
				name = "Noto Color Emoji";
			};
		};
		base16Scheme = {
			Scheme = "My Custom Theme";
			author = "Your Name";
			slug = "my-custom-theme";
			
			# Основные цвета фона и текста
			base00 = "#0c0c0c";  # Основной фон (background)
			base01 = "#2f2f2f";  # Более светлый фон
			base02 = "#535353";  # Фон выделения (selection background)
			base03 = "#767676";  # Комментарии, второстепенный текст
			
			# Цвета текста
			base04 = "#b9b9b9";  # Неактивный текст
			base05 = "#cccccc";  # Основной текст (foreground)
			base06 = "#dfdfdf";  # Акцентный текст
			base07 = "#f2f2f2";  # Яркий текст на темном фоне
			
			# Акцентные цвета
			base08 = "#e74856";  # Красный (ошибки, удаление)
			base09 = "#c19c00";  # Оранжевый (предупреждения, числа)
			base0A = "#f9f1a5";  # Желтый (строки, константы)
			base0B = "#16c60c";  # Зеленый (успех, функции)
			base0C = "#61d6d6";  # Голубой (комментарии, тип данных)
			base0D = "#3b78ff";  # Синий (ключевые слова, ссылки)
			base0E = "#b4009e";  # Фиолетовый (методы, операторы)
			base0F = "#13a10e";  # Пурпурный (специальные символы)
		};
	};

	
	# ========== WAYBAR ==========
	programs.waybar = {
		enable = true;
		systemd.enable = true;
		style = ''
			* {
				border: none;
				border-radius: 0;
				font-family: "Source Code Pro", monospace;
				font-size: 12px;
				min-height: 0;
			}

			window#waybar {
				background: #16191C;
				color: #AAB2BF;
			}

			#custom-launcher {
				padding: 0 10px 0 12px;
				color: #88C0D0;
				font-size: 16px;
			}

			#custom-launcher:hover {
				background: #2E3440;
			}

			#workspaces button {
				padding: 0 8px;
				color: #AAB2BF;
				background: transparent;
			}

			#workspaces button:hover {
				background: #2E3440;
			}

			#workspaces button.active {
				color: #88C0D0;
				background: #2E3440;
			}

			#workspaces button.focused {
				color: #f5c2e7;
				background: #2E3440;
				font-weight: bold;
			}

			#workspaces button.empty {
				color: #4C566A;
			}

			#workspaces button.current_output {
				opacity: 1;
			}

			#workspaces button:not(.current_output) {
				opacity: 0.6;
			}

			#window {
				padding: 0 15px;
				color: #88C0D0;
				font-weight: bold;
				font-style: italic;
			}

			window#waybar.empty #window {
				background-color: transparent;
				color: #4C566A;
				font-style: normal;
			}

			window#waybar.solo #window {
				color: #A3BE8C;
			}

			#tray, #language, #pulseaudio, #network, #cpu, #memory, #clock {
				padding: 0 10px;
			}

			#language {
				color: #B48EAD;
				background: #2E3440;
			}

			#language:hover {
				background: #3B4252;
			}

			#pulseaudio {
				color: #EBCB8B;
			}

			#pulseaudio.muted {
				color: #4C566A;
			}

			#network {
				color: #81A1C1;
			}

			#network.disconnected {
				color: #BF616A;
			}

			#cpu {
				color: #D08770;
			}

			#memory {
				color: #A3BE8C;
			}

			#clock {
				color: #88C0D0;
				font-weight: bold;
			}

			#tray {
				color: #5E81AC;
			}

			#tray > .passive {
				-gtk-icon-effect: dim;
			}

			#tray > .needs-attention {
				-gtk-icon-effect: highlight;
				color: #BF616A;
			}
		'';

		settings = {
			mainBar = {
				layer = "top";
				position = "top";
				height = 30;
				spacing = 4;

				modules-left = [ "custom/launcher" "niri/workspaces" ];
				modules-center = [ "niri/window" ];
				modules-right = [ "tray" "niri/language" "pulseaudio" "network" "cpu" "memory" "clock" ];

				"custom/launcher" = {
					format = "";
					on-click = "rofi -show drun";
					tooltip = false;
				};

				"niri/workspaces" = {
					format = "{icon}";
					format-icons = {
						"focused"= "󰮯";
						"active"= "󰝦";
						"default"= "󰊠";
						"empty"= "󰊡";
					};
					disable-click = false;
					current-only = false;
					all-outputs = false;
				};

				"niri/window" = {
					format = "{title}";
					rewrite = {
						"(.*) - Mozilla Firefox"= "🌎 $1";
						"(.*) - Kitty"= " $1";
						"kitty"= " Terminal";
					};
					separate-outputs = false;
					icon = false;
				};

				"niri/language" = {
					format = "{long}";
					format-en = "🇺🇸 EN";
					format-ru = "🇷🇺 RU";
					tooltip = false;
				};

				"tray" = {
					icon-size = 16;
					spacing = 8;
				};

				"pulseaudio" = {
					format = "{volume}% {icon}";
					format-bluetooth = "{volume}% {icon}";
					format-bluetooth-muted = "󰸈 {icon}";
					format-muted = "󰸈";
					format-icons = {
						default = [ "󰕿" "󰖀" "󰕾" ];
					};
					on-click = "pavucontrol";
					tooltip-format = "{desc}";
				};

				"network" = {
					format-wifi = "{essid} 󰖩";
					format-ethernet = "󰈀";
					format-disconnected = "󰖪";
					tooltip-format = "{ifname}: {ipaddr}/{cidr}";
					tooltip-format-wifi = "{essid} ({signalStrength}%) 󰖩";
				};

				"cpu" = {
					format = "󰍛 {usage}%";
					interval = 2;
					tooltip = false;
				};

				"memory" = {
					format = "󰍛 {}%";
					interval = 2;
				};

				"clock" = {
					format = "{:%H:%M:%S}";
					tooltip-format = "{:%A, %d %B %Y}\n<tt><small>{calendar}</small></tt>";
					format-alt = "{:%d/%m}";
				};
			};
		};
	};
	
	# ========== NIRI ==========
	programs.niri = {
		settings = {
			clipboard.disable-primary = false;
			screenshot-path = "~/Pictures/Screenshots/%Y-%m-%d %H:%M:%S.png";
			input = {
				focus-follows-mouse.enable = true;
				mod-key = "Super";
				keyboard.repeat-delay = 450;
				keyboard.repeat-rate = 30;
				keyboard.xkb = {
					layout = "us,ru";
					options = "grp:alt_shift_toggle";
				};
			};

			layout = {
				focus-ring.enable = false;
				border = {
					enable = true;
					width = 4;
					active.color = "#f5c2e7";
					inactive.color = "#9399b2";
				};
				gaps = 30;
				struts = {
					left = 10;
					top = -10;
					right = 10;
					bottom = -10;
				};
			};
			
			binds = {
				"Mod+Q" = { action.close-window = {}; };
				"Mod+Tab" = { action.toggle-overview = {}; };
				"Mod+Return" = { action.spawn = [ "kitty" ]; };
				"Mod+T" = { action.spawn = [ "kitty" ]; };
				"Mod+R" = { action.spawn-sh = [ "rofi -show drun" ]; };
				"Mod+Alt+L" = { action.spawn = [ "swaylock" ]; };

				"Mod+1" = { action.focus-workspace = 1; };
				"Mod+2" = { action.focus-workspace = 2; };
				"Mod+3" = { action.focus-workspace = 3; };
				"Mod+4" = { action.focus-workspace = 4; };
				"Mod+5" = { action.focus-workspace = 5; };
				"Mod+6" = { action.focus-workspace = 6; };
				"Mod+7" = { action.focus-workspace = 7; };
				"Mod+8" = { action.focus-workspace = 8; };
				"Mod+9" = { action.focus-workspace = 9; };

				"Mod+Shift+1" = { action.move-column-to-workspace = 1; };
				"Mod+Shift+2" = { action.move-column-to-workspace = 2; };
				"Mod+Shift+3" = { action.move-column-to-workspace = 3; };
				"Mod+Shift+4" = { action.move-column-to-workspace = 4; };
				"Mod+Shift+5" = { action.move-column-to-workspace = 5; };
				"Mod+Shift+6" = { action.move-column-to-workspace = 6; };
				"Mod+Shift+7" = { action.move-column-to-workspace = 7; };
				"Mod+Shift+8" = { action.move-column-to-workspace = 8; };
				"Mod+Shift+9" = { action.move-column-to-workspace = 9; };

				"Mod+Up" = { action.focus-window-or-workspace-up = {}; };
				"Mod+Down" = { action.focus-window-or-workspace-down = {}; };
				"Mod+Left" = { action.focus-column-left = {}; };
				"Mod+Right" = { action.focus-column-right = {}; };
				"Mod+Shift+Up" = { action.move-window-up-or-to-workspace-up = {}; };
				"Mod+Shift+Down" = { action.move-window-down-or-to-workspace-down = {}; };
				"Mod+Shift+Left" = { action.move-column-left = {}; };
				"Mod+Shift+Right" = { action.move-column-right = {}; };

				"Mod+Home" = { action.focus-column-first = {}; };
				"Mod+End" = { action.focus-column-last = {}; };
				"Mod+Ctrl+Home" = { action.move-column-to-first = {}; };
				"Mod+Ctrl+End" = { action.move-column-to-last = {}; };

				"Mod+Page_Down" = { action.focus-workspace-down = {}; };
				"Mod+Page_Up" = { action.focus-workspace-up = {}; };
				"Mod+Shift+Page_Down" = { action.move-window-to-workspace-down = {}; };
				"Mod+Shift+Page_Up" = { action.move-window-to-workspace-up = {}; };

				"Mod+Ctrl+Page_Down" = { action.move-workspace-down = {}; };
				"Mod+Ctrl+Page_Up" = { action.move-workspace-up = {}; };

				"Mod+WheelScrollRight" = { action.focus-column-right = {}; };
				"Mod+WheelScrollLeft" = { action.focus-column-left = {}; };
				"Mod+Ctrl+WheelScrollRight" = { action.move-column-right = {}; };
				"Mod+Ctrl+WheelScrollLeft" = { action.move-column-left = {}; };

				"Mod+Shift+WheelScrollDown" = { action.focus-column-right = {}; };
				"Mod+Shift+WheelScrollUp" = { action.focus-column-left = {}; };
				"Mod+Ctrl+Shift+WheelScrollDown" = { action.move-column-right = {}; };
				"Mod+Ctrl+Shift+WheelScrollUp" = { action.move-column-left = {}; };

				"Mod+F" = { action.maximize-column = {}; };
				"Mod+Shift+F" = { action.fullscreen-window = {}; };
				"Mod+space" = { action.toggle-window-floating = {}; };
				"Mod+Shift+space" = { action.switch-focus-between-floating-and-tiling = {}; };
				"Print" = { action.screenshot = {}; };
				# // The quit action will show a confirmation dialog to avoid accidental exits.
				"Mod+Shift+E" = { action.quit = {}; };
				"Ctrl+Alt+Delete" = { action.quit = {}; };
				"Mod+Shift+P" = { action.power-off-monitors = {}; };
			};
			environment = {
				# Базовые Wayland настройки
				XDG_SESSION_TYPE = "wayland";
				XDG_SESSION_DESKTOP = "niri";
				XDG_CURRENT_DESKTOP = "niri";

				# Терминал и редакторы
				TERMINAL = "kitty";
				EDITOR = "micro";
				SUDO_EDITOR = "micro";
				VISUAL = "subl";

				# Kitty
				KITTY_ENABLE_WAYLAND = "1";

				# GTK/ATK
				NO_AT_BRIDGE = "1";

				# NVIDIA Wayland поддержка
				GBM_BACKEND = "nvidia-drm";
				__GLX_VENDOR_LIBRARY_NAME = "nvidia";

				# GDK/Clutter
				GDK_BACKEND = "wayland,x11,*";
				CLUTTER_BACKEND = "wayland";
				CLUTTER_DEFAULT_FPS = "60";

				# Qt
				QT_QPA_PLATFORM = "wayland;xcb";
				QT_QPA_PLATFORMTHEME = "qt6ct";
				QT_QPA_PLATFORMTHEME_QT6 = "qt6ct";

				# SDL
				SDL_VIDEODRIVER = "wayland,x11,windows";

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
				MOZ_X11_EGL = "1";

				# NVIDIA Direct Rendering
				NVD_BACKEND = "direct";

				# OBS Studio
				OBS_USE_EGL = "1";

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
				vsync = "1";  # Может конфликтовать с vblank_mode=0

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
				PROTON_ENABLE_NGX_UPDATER = "1";
				PROTON_ENABLE_NVAPI = "1";
				PROTON_FORCE_LARGE_ADDRESS_AWARE = "1";
				PROTON_HIDE_NVIDIA_GPU = "0";
				PROTON_USE_NTSYNC = "1";
				# //PROTON_ENABLE_WAYLAND = "1";
				PROTON_LOG = "1";

				# VKD3D
				VKD3D_CONFIG = "dxr";

				# Wayland/XWayland
				vk_xwayland_wait_ready = "false";

				# GTK настройки
				GTK_USE_IEC_UNITS = "1";
				GTK_OVERLAY_SCROLLING = "1";
				GTK_USE_PORTAL = "1";
				GDK_DEBUG = "portals";

				# NixOS специфичные
				NIXOS_OZONE_WL = "1";

				# Telegram Desktop
				# TDESKTOP_USE_GTK_FILE_DIALOG = "1";
				# TDESKTOP_I_KNOW_ABOUT_GTK_INCOMPATIBILITY = "1";
			};
		};
	};

	home.activation.reloadNiri = lib.hm.dag.entryAfter ["writeBoundary"] ''
		if command -v niri >/dev/null 2>&1; then
		niri msg action reload-config 2>/dev/null || true
		fi
	'';
}
