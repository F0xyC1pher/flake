{ stdenv, config, pkgs, lib, inputs, vars, ... }:
{
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
