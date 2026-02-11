{ stdenv, config, pkgs, lib, inputs, vars, ... }:
{
	
	system.stateVersion = "25.05";
	
	# ========== NIXPKGS ==========
	nixpkgs = {
		overlays = [ inputs.niri.overlays.niri ];
		config = {
			allowUnfree = true;
			permittedInsecurePackages = [
				"openssl-1.1.1w"
			];
		};
	};
	
	# ========== NIX ==========
	nix = {
		package = pkgs.lix;
		settings = {
			experimental-features = [ "nix-command" "flakes" ];
				
			substituters = [
				"https://cache.nixos.org/"
				# "https://cache.garnix.io"
			];
			trusted-public-keys = [
				"cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
				# "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
			];
		};
	};
	
	# ========== BOOTLOADER ==========
	boot = {
		kernelPackages = pkgs.linuxPackages_xanmod_latest;
		extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
		blacklistedKernelModules = [ "nouveau" ];
		initrd.kernelModules = [ "nvidia" ];
		loader.grub = {
			enable = true;
			device = "/dev/sda";
		};
	};
	

	# ========== LOCALE ==========
	console = {
		font = "${pkgs.terminus_font}/share/consolefonts/ter-v14n.psf.gz";
		packages = with pkgs; [ terminus_font ];
		useXkbConfig = true;
		earlySetup = true;
		# keyMap = "ru";
	};
	i18n.defaultLocale = "ru_RU.UTF-8";
	i18n.supportedLocales = ["all"];
	
	# ========== NETWORK ==========
	time.timeZone = "Europe/Moscow";
	networking = {
		hostName = "${vars.hostName}";
		networkmanager = {
			enable = true;
			dns = "none";
		};
		useDHCP = false;
		firewall.enable = false;
		nameservers = [
			"1.1.1.1"
			"1.0.0.1"
		];
		hosts = {
			"94.131.119.22" = [ "grok.com" "x.ai" "accounts.x.ai" ];
		};
	};
	
	# ========== USER ==========
	users.users.${vars.userName} = {
		isNormalUser = true;
		description = "${vars.userLongName}";
		home = "/home/${vars.userName}";
		shell = pkgs.fish;
		extraGroups = [
			"networkmanager"
			"wheel"
			"video"
			"audio"
			"input"
			"rtkit"
			"render"
		];
	};
	
	security = {
		sudo.wheelNeedsPassword = false;
		rtkit.enable = true;
		polkit.enable = true;
	};
	
	# ========== SERVICES ==========
	services = {
		dbus.enable = true;
		gnome.gnome-keyring.enable = lib.mkForce false;
		desktopManager.gnome.enable = lib.mkForce false;
		
		pipewire = {
			enable = true;
			pulse.enable = true;
			jack.enable = true;
			wireplumber.enable = true;
			alsa = {	
				enable = true;
				support32Bit = true;
			};
		};
		
		xserver = {
			enable = true;
			videoDrivers = ["nvidia"];
			xkb = {
				layout = "us,ru";
				model = "pc86";
				options = "grp:lalt_lshift_toggle;";
			};
		};
		
		mpd = {
			enable = true;
			user = "${vars.userName}";
			settings = {
				music_directory = "/home/${vars.userName}/CoolStuff/Music";
				
				# Вот как теперь задаётся audio_output (это список, можно несколько блоков)
				audio_output = [
					{
						type = "pipewire";
						name = "My PipeWire Output";
						# Дополнительные параметры, если нужно (опционально):
						# format = "44100:16:2";      # пример
						# mixer_type = "software";
						# auto_resample = "no";
					}
				];
				# Если нужны другие простые параметры (не блоки), пиши их прямо здесь:
				# restore_paused = "yes";
				# max_playlist_length = "16384";
			};
			# network = {
			#     listenAddress = "any";          # если хочешь разрешить подключения не только с localhost
			#     startWhenNeeded = true;         # systemd socket activation — очень удобно
			#   };
			# Optional:
		#	network.listenAddress = "any"; # if you want to allow non-localhost connections
			startWhenNeeded = true; # systemd feature: only start MPD service upon connection to its socket
		};
		
		greetd = {
			enable = true;
			useTextGreeter = true;
			settings = {
				default_session = {
					command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --xsessions ${config.services.displayManager.sessionData.desktops}/share/xsessions --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions";
					user = "greeter";
				};
			};
		};
	};
	
	systemd.services.mpd.environment = {
		# https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
		XDG_RUNTIME_DIR = "/run/user/1000"; # User-id 1000 must match above user. MPD will look inside this directory for the PipeWire socket.
	};
	
	systemd.user.services.niri-flake-polkit.enable = false;
	# ========== FONTS ==========
	fonts = {
		packages = with pkgs; [
			monocraft
			minecraftia
			nerd-fonts.departure-mono
			nerd-fonts.fira-code
			fira-code-symbols
			font-awesome
			noto-fonts
			noto-fonts-color-emoji
		];
		
		fontconfig = {
			enable = true;
			cache32Bit = true;
			antialias = true;
			allowBitmaps = true;
			useEmbeddedBitmaps = true;
			subpixel = {
				rgba = "rgb";
				lcdfilter = "default";	
			};
			hinting = {
				enable = true;
				style = "slight";
				autohint = false;
			};
		};
	};
	
	# ========== PROGRAMS ==========
	programs = {
		fish.enable = true;
		bash.enable = true;
		
		niri = {
			enable = true;
			package = pkgs.niri-unstable;
		};
		
		mango = {
			enable = true;
		};
		
		hyprland = {
			enable = true;
			xwayland.enable = true;
			withUWSM = false;
			package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
		};
		
		uwsm.enable = true;
		
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
		
		yazi = {
			enable = true;
			plugins = {
				inherit (pkgs.yaziPlugins) sudo;
				inherit (pkgs.yaziPlugins) glow;
				inherit (pkgs.yaziPlugins) piper;
				inherit (pkgs.yaziPlugins) mount;
				inherit (pkgs.yaziPlugins) gitui;
				inherit (pkgs.yaziPlugins) chmod;
				inherit (pkgs.yaziPlugins) miller;
				inherit (pkgs.yaziPlugins) yatline;
				inherit (pkgs.yaziPlugins) mime-ext;
				inherit (pkgs.yaziPlugins) compress;
				inherit (pkgs.yaziPlugins) mediainfo;
				inherit (pkgs.yaziPlugins) toggle-pane;
				inherit (pkgs.yaziPlugins) full-border;
				# inherit (pkgs.yaziPlugins) ;
			};
		};
		
		appimage = {
			enable = true;
			binfmt = true;	
		};
	};
}
