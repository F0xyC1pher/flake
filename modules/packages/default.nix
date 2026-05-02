{
	vars,
	inputs,
	pkgs,
	...
}: let
	btoP = with pkgs;
		if vars.hardware.nvidia.enable
		then btop-cuda
		else if vars.hardware.amd.enable
		then btop-rocm
		else btop;
	nvtoP = with pkgs;
		if vars.hardware.nvidia.enable
		then nvtopPackages.nvidia
		else if vars.hardware.amd.enable
		then nvtopPackages.amd
		else nvtopPackages.full;
in {
	imports = [
	];
	environment.systemPackages = with pkgs;
	with inputs; [
		# 🖥️ Core & System Essentials (Основа системы)
		glib
		gvfs
		libnotify
		zenity
		unzip
		zip
		p7zip
		xz
		gzip
		file
		binutils
		pciutils
		usbutils
		util-linux # Содержит taskset
		smartmontools
		lm_sensors
		ethtool
		dnsutils
		socat
		libmtp

		# 📊 Monitoring & Resources (Мониторинг и анализ)
		btoP
		nvtoP
		iotop
		fastfetch
		powertop
		duf
		dua
		disktui
		diskscan
		diskus
		mediainfo
		exiftool

		# ⚡ Performance & Kernel (Производительность и тюнинг)
		# tuna
		# schedtool
		# scx.cscheds
		# cpufrequtils
		# irqbalance
		# numactl
		mesa-demos

		# 🛠️ Terminal Tools & CLI (Терминальные утилиты)
		yazi
		eza
		bat
		bat-extras.core
		fd
		# rgrc
		grc
		ripgrep-all
		fzf
		trash-cli
		glow
		less
		mcat
		babelfish
		pandoc
		imagemagick
		wget
		aria2
		lolcat
		# clolcat
		# dotacat
		# blahaj
		wayneko

		# 📂 Disk & Filesystem (Диски и ФС)
		parted
		gparted-full
		mtools

		# 💻 Development & Editors (Разработка и редакторы)
		obsidian
		git
		gitui
		git-credential-keepassxc
		color-lsp
		nixd
		nil
		alejandra
		package-version-server
		vscodium
		zed-editor
		# jetbrains.clion
		# micro-full
		gemini-cli-bin
		#gemini-cli
		#lagrange-tui
		tuios

		# 🌐 Networking & VPN (Сеть)
		sniffglue
		qbittorrent
		dropbox
		dropbox-cli

		# 🔊 Audio (Звук и его настройка)
		pavucontrol
		alsa-utils
		alsa-tools
		jack-example-tools
		rnnoise-plugin
		playerctl
		mpdris2

		# 🎵 Media & Streaming (Медиа контент)
		spotify
		youtube-tui
		termusic
		ytermusic
		yt-dlp
		ffmpeg-full
		ffmpegthumbnailer
		poppler
		obs-studio-plugins.obs-vaapi
		kew
		# inputs.rmpc.packages.${pkgs.stdenv.hostPlatform.system}.default

		# 🖼️ Wayland & Graphics (Графическая среда)
		wayland-utils
		xdg-utils
		xdg-user-dirs
		wlr-randr
		wev
		slurp
		wl-clipboard
		wl-clipboard-x11
		wl-clip-persist
		cliphist
		cliphist-fuzzel-img
		brightnessctl
		awww
		# inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww

		# 🚀 UI Components (Интерфейс и уведомления)
		rofi
		rofi-polkit-agent
		swaynotificationcenter
		cmd-polkit
		tuigreet

		# 🔐 Security (Безопасность)
		keepassxc
		sops
		openssh
		swaylock

		# 🔵 Bluetooth
		bluetui
		bluetuith

		# 📱 Mobile & Android (Мобильные устройства)
		android-tools
		android-file-transfer
		android-translation-layer
		extract-dtb

		# 🎮 Gaming (Игры)
		r2modman
		mangohud
		yetris
		inputs.freesmlauncher.packages.${pkgs.stdenv.hostPlatform.system}.freesmlauncher

		# 🍷 Wine & Compatibility (Совместимость с Windows)
		wineWow64Packages.stagingFull
		wineWow64Packages.waylandFull
		wineWow64Packages.fonts
		wineasio
		winetricks

		# 📨 Communication (Мессенджеры)
		ayugram-desktop
		discordo
		discord-gamesdk
		arrpc
		rustdesk-flutter

		nvidia-vaapi-driver
		libva-vdpau-driver
		libvdpau-va-gl

		gpu-screen-recorder
		gpu-screen-recorder-gtk
		niri-float-sticky.packages.${stdenv.hostPlatform.system}.default
	];
	# ++ (
	# 	if vars.hardware.nvidia.enable
	# 	then [
	# 		nvidia-vaapi-driver
	# 		libva-vdpau-driver
	# 		libvdpau-va-gl
	# 	]
	# 	else []
	# );
}
