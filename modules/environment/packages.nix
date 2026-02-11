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
			ntfs3g
			micro-full
			fd
			btop
			wget
			tuigreet
			gst_all_1.gstreamer
			gst_all_1.gst-plugins-base
			gst_all_1.gst-plugins-good
			gst_all_1.gst-plugins-bad
			gst_all_1.gst-plugins-ugly
			gst_all_1.gst-libav
			gst_all_1.gst-vaapi
		];
	};
	
	home-manager.users.${vars.userName} = { config, pkgs, lib, ... }: {
		home.packages = with pkgs; [
			inputs.rmpc.packages.${pkgs.stdenv.hostPlatform.system}.default
			inputs.freesmlauncher.packages.${pkgs.stdenv.hostPlatform.system}.freesmlauncher
			ayugram-desktop
			cmd-polkit
			jq
			yazi
			kitty
			sublime4
			vscodium
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
			wl-clipboard
			wl-clipboard-x11
			wl-clip-persist
			cliphist
			wayland-utils
			slurp
			xwayland-satellite-unstable
			keepassxc
			git-credential-keepassxc
			cmd-polkit 
			jq
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
			helix
			gst_all_1.gstreamer
			gst_all_1.gst-plugins-base
			gst_all_1.gst-plugins-good
			gst_all_1.gst-plugins-bad
			gst_all_1.gst-plugins-ugly
			gst_all_1.gst-libav
			gst_all_1.gst-vaapi
		];
	};
}
