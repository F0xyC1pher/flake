{
	vars,
	inputs,
	pkgs,
	...
}: {
	nix = {
		# package = pkgs.lix;
		package = pkgs.nix;
		settings = {
			auto-optimise-store = true;
			builders-use-substitutes = true;
			warn-dirty = false;
			eval-cache = true;
			experimental-features = [
				"nix-command"
				"flakes"
				# "flake-self-attrs"
			];
			trusted-users = [
				"${vars.user.name}"
				"root"
				"@wheel"
			];
			# extra-deprecated-features = ["url-literals"];
			substituters = [
				"https://cache.garnix.io"
				"https://ayugram-desktop.cachix.org"
				"https://nix-community.cachix.org"
				"https://niri.cachix.org"
				"https://cache.nixos.org"
			];
			trusted-public-keys = [
				"cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
				"ayugram-desktop.cachix.org:AZ5EqHrJsAKL5YkZYLPEsb1FdD9QlypUwQ0REcJftgA="
				"nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
				"niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
				"cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
			];
		};
	};
	nixpkgs.config.allowUnfree = true;
	nixpkgs.overlays = with inputs; [
		niri.overlays.niri
		nix-firefox-addons.overlays.default
		(final: prev: {
				kitty =
					prev.kitty.overrideAttrs (oldAttrs: {
							postPatch =
								(oldAttrs.postPatch or "")
								+ ''
									substituteInPlace kitty/fast_data_types.pyi \
									  --replace "allow_bitmapped_fonts: bool = False" "allow_bitmapped_fonts: bool = True"
									substituteInPlace kitty/fontconfig.c \
									  --replace "int allow_bitmapped_fonts = 0" "int allow_bitmapped_fonts = 1"
									substituteInPlace kitty/fontconfig.c \
									  --replace 'if (!scalable) continue' '/* if (!scalable) continue */' \
									  --replace 'if (scalable == FcFalse) continue' '/* if (scalable == FcFalse) continue */'
									substituteInPlace kitty/fonts/fontconfig.py \
									  --replace 'scalable_only=True' 'scalable_only=False' \
									  --replace 'scalable_only = True' 'scalable_only = False' \
									  || true
									substituteInPlace kitty/fontconfig.c \
									  --replace 'FcPatternAddBool(pat, FC_SCALABLE, FcTrue)' '/* FcPatternAddBool(pat, FC_SCALABLE, FcTrue) */' \
									  --replace 'FcPatternAddBool(pat, FC_SCALABLE, FcFalse)' '/* FcPatternAddBool(pat, FC_SCALABLE, FcFalse) */'
								'';
						});
			})
	];
}
