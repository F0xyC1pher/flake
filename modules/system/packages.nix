{
	inputs,
	pkgs,
	...
}: {
	#	==========ENVIRONMENT==========
	environment = {
		#		==========PACKAGES==========
		systemPackages = with pkgs; [
			# go
			# gcc
			# pkg-config

			glib

			dropbox
			dropbox-cli
			# Bluetooth
			bluetui
			bluetuith
			# VPN
			nekobox
			libsForQt5.qtstyleplugin-kvantum
			sing-box

			# 🔧 Системные утилиты и инструменты
			# Мониторинг
			btop
			iotop
			pciutils
			usbutils
			lm_sensors
			ethtool
			dnsutils
			smartmontools
			duf
			fastfetch
			powertop

			# Настройка производительности
			tuna # Настройка IRQ и affinity
			schedtool # Управление планировщиком
			scx.cscheds
			util-linux # Содержит taskset Управление affinity
			cpufrequtils
			irqbalance
			numactl

			# Аудио инструменты
			jack-example-tools # jack_connect, jack_lsp и др.
			alsa-utils # alsamixer, aplay, arecord
			alsa-tools # hdajackretask, hda-verb

			# 🛠 Терминальное
			kitty
			babelfish
			gvfs
			libmtp
			# mtpfs
			yazi
			pandoc
			eza
			bat
			bat-extras.core
			fd
			rgrc
			grc
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
			mcat
			# disks
			parted
			gparted-full
			mtools

			# 📱 Android и мобильное
			android-tools
			android-file-transfer
			android-translation-layer
			extract-dtb

			# 📦 Архивы и сжатие
			p7zip
			unzip
			zip
			xz
			gzip

			# 🐧 Nix и разработка
			nixd
			alejandra
			package-version-server
			micro-full
			vscodium
			zed-editor
			jetbrains.clion
			git
			gitui
			# lazygit
			git-credential-keepassxc

			# 🎵 Медиа и Звук
			# inputs.rmpc.packages.${pkgs.stdenv.hostPlatform.system}.default
			rmpc
			mpd
			mpdris2
			# musikcube
			playerctl
			pavucontrol
			ffmpeg-full
			yt-dlp

			# 🖼 Обои и анимации (Wayland)
			# inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
			awww

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

			# 🌐 Сеть и скачивание
			wget
			aria2
			qbittorrent

			# 🎮 Игры и лаунчеры
			inputs.freesmlauncher.packages.${pkgs.stdenv.hostPlatform.system}.freesmlauncher
			mangohud
			yetris

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
			# discord-rpc
			arrpc
			rustdesk-flutter

			# 🎥 Запись и стриминг
			obs-studio-plugins.obs-vaapi

			# 🔧 VA-API / Аппаратное ускорение (NVIDIA + Intel/AMD)
			libva-vdpau-driver
			libvdpau-va-gl
			nvidia-vaapi-driver
			# gst_all_1.gstreamer
			# gst_all_1.gst-plugins-base
			# gst_all_1.gst-plugins-good
			# gst_all_1.gst-plugins-bad
			# gst_all_1.gst-plugins-ugly
			# gst_all_1.gst-libav
			# gst_all_1.gst-vaapi

			# 🧹 Остальное / Полезные утилиты
			libnotify
			imagemagick
			pandoc
			socat
			# 📥 Из inputs (flake inputs)
			# inputs.nixos-conf-editor.packages.${pkgs.stdenv.hostPlatform.system}.nixos-conf-editor  # закомментировано
			# inputs.pawbar.packages.${pkgs.stdenv.hostPlatform.system}.default
		];
	};

	# home-manager.users.${vars.userName} = { config, pkgs, lib, ... }: {
	# 	home.packages = with pkgs; [
	#
	# 	];
	# };
}
