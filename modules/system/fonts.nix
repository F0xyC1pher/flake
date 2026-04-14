{pkgs, ...}: {
	# ========== FONTS ==========
	fonts = {
		packages = with pkgs; [
			fira-code-symbols
			nerd-fonts.fira-code
			nerd-fonts.departure-mono
			noto-fonts
			noto-fonts-color-emoji
			noto-fonts-cjk-sans
			font-awesome
			cozette
			monocraft
			minecraftia
			inter

			nerd-fonts.hack
			nerd-fonts.caskaydia-cove
			nerd-fonts.caskaydia-mono

			inconsolata

			monocraft
			minecraftia

			inter

			roboto
			roboto-mono
			roboto-flex
			roboto-serif

			googlesans-code

			ubuntu-sans

			material-symbols
		];

		#	==========	FONTCONFIG	==========
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
}
