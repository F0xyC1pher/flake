{
	vars,
	inputs,
	pkgs,
	...
}: {
	imports = [
		./neu-nix.nix
		./jdk.nix
	];
	services.displayManager.sessionPackages = [inputs.driftwm.packages.x86_64-linux.default pkgs.niri];
	environment.systemPackages = with pkgs; [
		(
			if vars.hardware.nvidia.enable
			then nvidia-vaapi-driver
			else []
		)
		(
			if vars.hardware.nvidia.enable
			then btop-cuda
			else if vars.hardware.amd.enable
			then btop-rocm
			else btop
		)
		nvtopPackages.${
			if vars.hardware.nvidia.enable
			then "nvidia"
			else if vars.hardware.amd.enable
			then "amd"
			else "full"
		}
		curl-impersonate
		curlFull
		mcpelauncher-client
		mcpelauncher-ui-qt
		qt6Packages.qt6ct
		papirus-icon-theme
		unzip
		zip
		p7zip
		libmtp
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
		tree
		treecat
		treemd
		tree-from-tags
		tuna
		scx.cscheds
		numactl
		mesa-demos
		eza
		bat
		bat-extras.core
		fd
		grc
		ripgrep-all
		ripgrep
		rippkgs
		ripdrag
		dragon-drop
		fzf
		trash-cli
		glow
		less
		mcat
		babelfish
		imagemagick
		wget
		aria2
		lolcat
		clolcat
		dotacat
		blahaj
		wayneko
		kittysay
		pixcat
		parted
		gparted-full
		mtools
		ntfs3g
		f2fs-tools
		btrfs-progs
		obsidian
		gitui
		github-cli
		git-credential-keepassxc
		color-lsp
		nixd
		nil
		package-version-server
		sniffglue
		qbittorrent
		dropbox
		dropbox-cli
		pavucontrol
		alsa-utils
		alsa-tools
		jack-example-tools
		playerctl
		mpdris2
		catnip
		cavasik
		youtube-tui
		termusic
		ytermusic
		yt-dlp
		yt-dlg
		ytdl-sub
		ytfzf

		video-downloader
		parabolic
		media-downloader
		tartube-yt-dlp

		obs-studio-plugins.obs-vaapi
		wayland-utils
		wlr-randr
		wev
		slurp
		wl-clipboard
		wl-clipboard-x11
		cliphist-fuzzel-img
		keepassxc
		sops
		swaylock
		bluetuith
		android-tools
		extract-dtb
		r2modman
		yetris
		freesmlauncher-custom
		wineWow64Packages.stagingFull
		wineWow64Packages.waylandFull
		wineWow64Packages.fonts
		wineasio
		winetricks
		discordo
		discord-gamesdk
		rustdesk-flutter
		libva-vdpau-driver
		libvdpau-va-gl
		gpu-screen-recorder
		gpu-screen-recorder-gtk
		xwayland-satellite
		adw-gtk3
		adwsteamgtk
		rmtrash
		tor-browser
		teamspeak6-client
		inputs.ayugram-desktop.packages.${stdenv.hostPlatform.system}.default
		inputs.nyoom.packages.${stdenv.hostPlatform.system}.nyoom
		inputs.niri-float-sticky.packages.${stdenv.hostPlatform.system}.default
		inputs.driftwm.packages.x86_64-linux.default
		inputs.alejandra.defaultPackage.${stdenv.hostPlatform.system}
	];
}
