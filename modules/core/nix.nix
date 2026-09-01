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
			];
			trusted-users = [
				"${vars.user.name}"
				"root"
				"@wheel"
			];
			trusted-substituters = [
				"https://hyprland.cachix.org"
				"https://ayugram-desktop.cachix.org"
				"https://nix-community.cachix.org"
				"https://niri.cachix.org"
				"https://cache.nixos.org"
				"https://cache.garnix.io"
				"https://freesmlauncher.cachix.org"
			];
			trusted-public-keys = [
				"hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
				"ayugram-desktop.cachix.org-1:AZ5EqHrJsAKL5YkZYLPEsb1FdD9QlypUwQ0REcJftgA="
				"nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
				"niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
				"cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
				"cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
				"freesmlauncher.cachix.org-1:Jcp5Q9wiLL+EDv8Mh7c6L9xGk+lXr7/otpKxMOuBuDs="
			];
			extra-substituters = [
				"https://tg-owt.cachix.org"
				"https://yazi.cachix.org"
			];
			extra-trusted-public-keys = [
				"tg-owt.cachix.org-1:lp0BukIhSK3EIyLcDhDZ5zABgT48nmNp6t4SnZ0wr8w="
				"yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
			];
		};
	};
	nixpkgs.config.allowUnfree = true;
	nixpkgs.overlays = [
		inputs.nix-firefox-addons.overlays.default

		(final: prev: {
				kitty =
					prev.kitty.overrideAttrs (oldAttrs: {
							postPatch =
								(oldAttrs.postPatch or "")
								+ ''
									# Отключаем отбраковку нескалируемых шрифтов в fontconfig.c
									substituteInPlace kitty/fontconfig.c \
									  --replace 'if (!scalable) continue;' '/* if (!scalable) continue; */' \
									  --replace 'if (scalable == FcFalse) continue;' '/* if (scalable == FcFalse) continue; */'

									# Фоллбэк для вертикальных метрик, если OTB отдаёт 0/1px
									substituteInPlace kitty/fonts.c \
									  --replace 'if (line_height < 2)' 'line_height = 13; if (0)'
								'';
						});
			})
		# (final: prev: {
		# 		kitty =
		# 			prev.kitty.overrideAttrs (oldAttrs: {
		# 					postPatch =
		# 						(oldAttrs.postPatch or "")
		# 						+ ''
		# 							substituteInPlace kitty/fast_data_types.pyi \
		# 							  --replace "allow_bitmapped_fonts: bool = False" "allow_bitmapped_fonts: bool = True"
		# 							substituteInPlace kitty/fontconfig.c \
		# 							  --replace "int allow_bitmapped_fonts = 0" "int allow_bitmapped_fonts = 1"
		# 							substituteInPlace kitty/fontconfig.c \
		# 							  --replace 'if (!scalable) continue' '/* if (!scalable) continue */' \
		# 							  --replace 'if (scalable == FcFalse) continue' '/* if (scalable == FcFalse) continue */'
		# 							substituteInPlace kitty/fonts/fontconfig.py \
		# 							  --replace 'scalable_only=True' 'scalable_only=False' \
		# 							  --replace 'scalable_only = True' 'scalable_only = False'
		# 							substituteInPlace kitty/fontconfig.c \
		# 							  --replace 'FcPatternAddBool(pat, FC_SCALABLE, FcTrue)' '/* FcPatternAddBool(pat, FC_SCALABLE, FcTrue) */' \
		# 							  --replace 'FcPatternAddBool(pat, FC_SCALABLE, FcFalse)' '/* FcPatternAddBool(pat, FC_SCALABLE, FcFalse) */'
		# 						'';
		# 				});
		# 	})
	];
}
