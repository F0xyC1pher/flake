{
	inputs,
	vars,
	pkgs,
	config,
	...
}:
{
#	==========ENVIRONMENT==========
	environment = {
		
#		==========PACKAGES==========
		systemPackages = with pkgs; [
			git
			git-credential-keepassxc
			ntfs3g
			micro-full
			fd
			btop
			wget
			tuigreet
			pciutils
			usbutils
			rustdesk-flutter
			# inputs.rmpc.packages.${pkgs.stdenv.hostPlatform.system}.default
			inputs.freesmlauncher.packages.${pkgs.stdenv.hostPlatform.system}.freesmlauncher
			ayugram-desktop
			jq
			yazi
			kitty
			sublime4
			vscodium
			musikcube
			nixd
			nil
			nixfmt
			package-version-server
			android-tools
			zenity
			mangohud
			swww
			fzf
			bluetuith
			tor-browser
			discord
			discordo
			discord-gamesdk
			discord-rpc
			arrpc
				# ripcord
				# overlayed
				# goofcord
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
			eza
			bat
			zed-editor
			lapce
			socat
			ripgrep-all
			pavucontrol
			fastfetch
			cliphist
			wl-clipboard
			wl-clipboard-x11
			wl-clip-persist
			wayland-utils
			helix
			slurp
			keepassxc
			rofi
			swaylock
			swaynotificationcenter
			mpv
			mpd
			mpdris2
			obsidian
			libva-vdpau-driver
			libvdpau-va-gl
			obs-studio-plugins.obs-vaapi
			nvidia-vaapi-driver
			cmd-polkit
			niri-unstable
			xwayland-satellite-unstable
			
			# required for preview
			    file
			    less
			    bat
			    glow
			
			    # media preview
			    mediainfo
			    ffmpegthumbnailer
			    ffmpeg
			
			    # archives
			    p7zip
			    unzip
			    zip
			    xz
			    gzip
			
			    # git integration
			    git
			    gitui
			
			    # utils
			    miller
			
				poppler
				imagemagick
				exiftool
			gst_all_1.gstreamer
			gst_all_1.gst-plugins-base
			gst_all_1.gst-plugins-good
			gst_all_1.gst-plugins-bad
			gst_all_1.gst-plugins-ugly
			gst_all_1.gst-libav
			gst_all_1.gst-vaapi
		];
	};
	
	# home-manager.users.${vars.userName} = { config, pkgs, lib, ... }: {
	# 	home.packages = with pkgs; [
	# 		
	# 	];
	# };
}
