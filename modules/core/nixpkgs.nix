{inputs, ...}: {
	nixpkgs.config.allowUnfree = true;
	nixpkgs.overlays = [
		inputs.nix-firefox-addons.overlays.default

		# (final: prev: {
		# 		kitty =
		# 			prev.kitty.overrideAttrs (oldAttrs: {
		# 					postPatch =
		# 						(oldAttrs.postPatch or "")
		# 						+ ''
		# 							# Отключаем отбраковку нескалируемых шрифтов в fontconfig.c
		# 							substituteInPlace kitty/fontconfig.c \
		# 							  --replace 'if (!scalable) continue;' '/* if (!scalable) continue; */' \
		# 							  --replace 'if (scalable == FcFalse) continue;' '/* if (scalable == FcFalse) continue; */'

		# 							# Фоллбэк для вертикальных метрик, если OTB отдаёт 0/1px
		# 							substituteInPlace kitty/fonts.c \
		# 							  --replace 'if (line_height < 2)' 'line_height = 13; if (0)'
		# 						'';
		# 				});
		# 	})
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
