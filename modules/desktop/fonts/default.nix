# ── Fonts — NixOS + HM fontconfig ────────────────────────────────────────────
# Replaces stylix.targets.fontconfig and stylix.fonts.
# system/services.nix fonts block should be removed to avoid duplication.
{
	pkgs,
	vars,
	...
}: {
	# ── NixOS-level font configuration ──────────────────────────────────────────
	fonts = {
		packages = with pkgs; [
			aporetic
			cozette
			fira-code-symbols
			font-awesome
			googlesans-code
			inconsolata
			inter
			material-symbols
			minecraftia
			monocraft
			nerd-fonts.caskaydia-cove
			nerd-fonts.caskaydia-mono
			nerd-fonts.departure-mono
			nerd-fonts.fira-code
			nerd-fonts.hack
			nerd-fonts.symbols-only
			newcomputermodern
			noto-fonts
			noto-fonts-cjk-sans
			noto-fonts-color-emoji
			roboto
			roboto-flex
			roboto-mono
			roboto-serif
			ubuntu-sans
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
