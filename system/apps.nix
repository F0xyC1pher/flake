{
	inputs,
    # config,
    pkgs,
    ...
}:
{
	environment.systemPackages = with pkgs; [
	    yazi
	    inputs.freesmlauncher.packages.${pkgs.stdenv.hostPlatform.system}.freesmlauncher
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
		vscodium
		swww
		fzf
		# kdePackages.qt6ct
		# kdePackages.qtstyleplugin-kvantum
		wget
		btop
		bluetuith
		firefox
		tor-browser
		discord
		discordo
		discord-gamesdk
		discord-rpc
		# ripcord
		# overlayed
		# goofcord
		arrpc
		nixfmt
		# mpvScripts.mpv-discord
		# moonlight
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
		lapce
		socat
		ripgrep-all
		pavucontrol
		fastfetch
		wl-clipboard
		wl-clipboard-x11
		wl-clip-persist
		cliphist
		wayland-utils
		slurp
		xwayland-satellite-unstable
		keepassxc
		git-credential-keepassxc
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
}
