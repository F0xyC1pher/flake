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

	services.displayManager.sessionPackages = [
		inputs.niri-glass.packages.${pkgs.stdenv.hostPlatform.system}.default
	];

	environment.systemPackages = with pkgs;
		[
			(
				if vars.hardware.video.driver.nvidia.enable
				then btop-cuda
				else if vars.hardware.video.driver.amd.enable
				then btop-rocm
				else btop
			)

			nvtopPackages.${
				if vars.hardware.video.driver.nvidia.enable
				then "nvidia"
				else if vars.hardware.video.driver.amd.enable
				then "amd"
				else "full"
			}
			# themix-gui
			# wpgtk
			# tor-browser
			# teamspeak6-client
			aseprite
			curl-impersonate
			curlFull
			qt6Packages.qt6ct
			qt6Packages.qtstyleplugin-kvantum
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
			mesa-demos
			eza
			bat
			bat-extras.core
			fd
			grc
			ripgrep-all
			ripgrep
			rippkgs
			fzf
			trash-cli
			glow
			less
			mcat
			babelfish
			imagemagick
			wget
			aria2
			dotacat
			blahaj
			wayneko
			kittysay
			parted
			gparted-full
			mtools
			ntfs3g
			btrfs-progs
			obsidian
			gitui
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
			ytdl-sub
			ytfzf
			parabolic
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
			bluetuith
			android-tools
			extract-dtb
			r2modman
			yetris
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
			xwayland-satellite
			adw-gtk3
			rmtrash
			ayugram-desktop

			# inputs.ayugram-desktop.packages.${system}.default
			(inputs.freesmlauncher.packages.${pkgs.stdenv.hostPlatform.system}.freesmlauncher.override {
					jdks = inputs.freesmlauncher.packages.${pkgs.stdenv.hostPlatform.system}.jvmPack.temurin;
				})
			inputs.nyoom.packages.${pkgs.stdenv.hostPlatform.system}.nyoom
			inputs.niri-float-sticky.packages.${pkgs.stdenv.hostPlatform.system}.default
			# # inputs.driftwm.packages.x86_64-linux.default
			inputs.alejandra.defaultPackage.${pkgs.stdenv.hostPlatform.system}
		]
		++ lib.optionals isNvidia [
			nvidia-vaapi-driver
		];
}
