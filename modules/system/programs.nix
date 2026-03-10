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
		extraSpecialArgs = { inherit inputs vars; };
		users.${vars.userName} =  { config, pkgs, lib, ... }: {
		# 	programs.emacs = {
		# 		enable = true;
		# 		package = pkgs.emacs-gtk;
		# #		extraConfig = ''
		# #			(setq standard-indent 2)
		# #		'';
		# 	};
		# 	
		# 	programs.helix = {
		# 		enable = true;
		# 		languages.language = [
		# 			{
		# 				name = "nix";
		# 				auto-format = true;
		# 				formatter.command = lib.getExe pkgs.nixfmt;
		# 			};
		# 		];
			# };
		};
	};
}
