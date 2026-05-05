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
				monospace = [vars.fontName];
				sansSerif = [vars.fontName];
				serif = [vars.fontName];
				emoji = ["Noto Color Emoji"];
			};
		};
	};

	# ── HM fontconfig ────────────────────────────────────────────────────────────
	home-manager.users.${vars.userName} = {...}: {
		fonts.fontconfig.enable = true;

		xdg.configFile."fontconfig/conf.d/10-foxychipherx.conf".text = ''
			<?xml version="1.0"?>
			<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
			<fontconfig>
			  <!-- Prefer main font for every generic family -->
			  <alias>
			    <family>monospace</family>
			    <prefer><family>${vars.fontName}</family></prefer>
			  </alias>
			  <alias>
			    <family>sans-serif</family>
			    <prefer><family>${vars.fontName}</family></prefer>
			  </alias>
			  <alias>
			    <family>serif</family>
			    <prefer><family>${vars.fontName}</family></prefer>
			  </alias>

			  <!-- Global rendering tweaks -->
			  <match target="font">
			    <edit name="antialias"  mode="assign"><bool>true</bool></edit>
			    <edit name="hinting"    mode="assign"><bool>true</bool></edit>
			    <edit name="hintstyle"  mode="assign"><const>hintslight</const></edit>
			    <edit name="rgba"       mode="assign"><const>rgb</const></edit>
			    <edit name="lcdfilter" mode="assign"><const>lcddefault</const></edit>
			  </match>
			</fontconfig>
		'';
	};
}
