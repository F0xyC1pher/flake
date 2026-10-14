# ── Fonts — NixOS + HM fontconfig ────────────────────────────────────────────
{
	pkgs,
	vars,
	...
}: {
	# ── NixOS-level font configuration ──────────────────────────────────────────
	fonts = {
		packages = with pkgs; [
			noto-fonts-color-emoji
			monocraft
			pixel-code
			cozette
			comic-mono
			comic-neue
			comic-relief
			commit-mono
			inter
			iosevka
			cascadia-code
			fira-code
			fira-code-symbols
			material-symbols
			font-awesome
			nerd-fonts.symbols-only
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

			defaultFonts = {
				monospace = [vars.theme.font.name "Symbols Nerd Font Mono"];
				sansSerif = [vars.theme.font.name "Symbols Nerd Font Mono"];
				serif = [vars.theme.font.name "Symbols Nerd Font Mono"];
				emoji = ["Noto Color Emoji" "Symbols Nerd Font Mono"];
			};
		};
	};
}
