# ── Fonts — NixOS + HM fontconfig ────────────────────────────────────────────
{
	pkgs,
	vars,
	...
}: {
	# ── NixOS-level font configuration ──────────────────────────────────────────
	fonts = {
		packages = with pkgs; [
			monocraft
			fira-code-symbols
			font-awesome
			material-symbols
			inter
			nerd-fonts.caskaydia-cove
			cozette
			lilex
			pixel-code
			nerd-fonts.fira-code
			nerd-fonts.departure-mono
			nerd-fonts.symbols-only
			# noto-fonts-cjk-sans
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

			defaultFonts = {
				monospace = [vars.theme.font.name];
				sansSerif = [vars.theme.font.name];
				serif = [vars.theme.font.name];
				emoji = ["Noto Color Emoji"];
			};
		};
	};
}
