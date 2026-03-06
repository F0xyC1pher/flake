{ stdenv, config, pkgs, lib, inputs, vars, ... }:
{
	# ========== PROGRAMS ==========
	programs = {
		fish.enable = true;
		bash.enable = true;
		
		niri = {
			enable = true;
			package = pkgs.niri-unstable;
		};
		
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
		
		appimage = {
			enable = true;
			binfmt = true;	
		};
	};
}
