{
	inputs,
	vars,
	pkgs,
	# config,
	...
}:
let
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
			rofi-polkit-agent
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
			firefox
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
		];
		
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
	};
}
