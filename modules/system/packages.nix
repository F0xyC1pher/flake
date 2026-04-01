{
	inputs,
	# vars,
	pkgs,
	# config,
	...
}: {
	#	==========ENVIRONMENT==========
	environment = {
		#		==========PACKAGES==========
		systemPackages = with pkgs; [
			nekobox-bin
			sing-box

			# 🔧 Системные утилиты и инструменты
			pciutils
			usbutils
			lm_sensors
			ethtool
			dnsutils
			smartmontools
			duf
			glances
			btop
			fastfetch

			# 🛠 Файловые менеджеры и работа с файлами
			yazi
			eza
			bat
			fd
			ripgrep-all
			fzf
			trash-cli
			mediainfo
			ffmpegthumbnailer
			file
			less
			glow
			poppler
			exiftool

			# 📦 Архивы и сжатие
			p7zip
			unzip
			zip
			xz
			gzip

			# 🐧 Nix и разработка
			nixd
			nil
			nixfmt
			alejandra
			package-version-server
			micro-full
			vscodium
			zed-editor
			lapce
			git
			gitui
			lazygit
			git-credential-keepassxc

			# 🎵 Медиа и Звук
			inputs.rmpc.packages.${pkgs.stdenv.hostPlatform.system}.default
			# rmpc
			mpd
			mpdris2
			musikcube
			playerctl
			pavucontrol
			mpv
			ffmpeg-full
			yt-dlp

			# 🖼 Обои и анимации (Wayland)
			inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww

			# 🔐 Безопасность и шифрование
			keepassxc
			sops
			openssh
			swaylock

			# 🚀 Запуск приложений и меню
			rofi
			rofi-polkit-agent
			swaynotificationcenter
			zenity
			libnotify
			cmd-polkit
			tuigreet

			# 🖥 Терминал и оболочка
			kitty
			cool-retro-term
			babelfish

			# 🌐 Сеть и скачивание
			wget
			aria2
			qbittorrent

			# 📱 Android и мобильное
			android-tools

			# 🎮 Игры и лаунчеры
			inputs.freesmlauncher.packages.${pkgs.stdenv.hostPlatform.system}.freesmlauncher
			mangohud

			# 🛠 Wine / Windows-приложения
			wineWow64Packages.stagingFull
			wineWow64Packages.waylandFull
			wineWow64Packages.fonts
			wineasio
			winetricks

			# 🪟 Wayland / Графика
			wayland-utils
			wlr-randr
			wev
			slurp
			wl-clipboard
			wl-clipboard-x11
			wl-clip-persist
			cliphist
			brightnessctl

			# 📨 Мессенджеры и коммуникация
			ayugram-desktop
			discordo
			discord-gamesdk
			discord-rpc
			arrpc
			rustdesk-flutter

			# 🎥 Запись и стриминг
			obs-studio-plugins.obs-vaapi

			# 🔧 VA-API / Аппаратное ускорение (NVIDIA + Intel/AMD)
			libva-vdpau-driver
			libvdpau-va-gl
			nvidia-vaapi-driver
			gst_all_1.gstreamer
			gst_all_1.gst-plugins-base
			gst_all_1.gst-plugins-good
			gst_all_1.gst-plugins-bad
			gst_all_1.gst-plugins-ugly
			gst_all_1.gst-libav
			gst_all_1.gst-vaapi

			# 🧹 Остальное / Полезные утилиты
			libnotify
			imagemagick
			pandoc
			socat

			# 📥 Из inputs (flake inputs)
			# inputs.nixos-conf-editor.packages.${pkgs.stdenv.hostPlatform.system}.nixos-conf-editor  # закомментировано
		];
	};

	# home-manager.users.${vars.userName} = { config, pkgs, lib, ... }: {
	# 	home.packages = with pkgs; [
	#
	# 	];
	# };
}
