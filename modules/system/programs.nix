{
	pkgs,
	inputs,
	vars,
	...
}: {
	# ========== PROGRAMS ==========
	programs = {
		fish.enable = true;
		zoxide.enableBashIntegration = true;
		bash = {
			enable = true;
			completion.enable = true;
		};

		ssh.startAgent = true;

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

		nh = {
			enable = true;
		};

		neovim = {
			enable = true;
			# configure = {
			# packages.myVimPackage = with pkgs.vimPlugins; {
			# 	start = [ ctrlp ];
			# };
			# };
		};

		gamemode.enable = true;

		# waybar = {
		# 	enable = true;
		# };

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

	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
		};
	};
}
