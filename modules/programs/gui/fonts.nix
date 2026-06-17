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
			nerd-fonts.caskaydia-cove
			nerd-fonts.fira-code
			fira-code-symbols
			nerd-fonts.symbols-only
			material-symbols
			font-awesome
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
				monospace = [vars.theme.font.name];
				sansSerif = [vars.theme.font.name];
				serif = [vars.theme.font.name];
				emoji = ["Noto Color Emoji"];
			};
		};
	};
}
