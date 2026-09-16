# lib/default.nix
{
	lib,
	inputs,
	system ? "x86_64-linux",
	flakeRoot ? ../.,
	themesDir ? "${flakeRoot}/themes",
}: let
	# 1. Colors
	converters = import ./colors/converters.nix {inherit lib;};
	validators = import ./colors/validators.nix {inherit lib;};
	math = import ./colors/math.nix {inherit lib converters;};

	colorUtils = converters // validators // math;

	# 2. Theme Engine
	paletteBuilder = import ./theme-engine/palette.nix {inherit lib colorUtils;};
	defaultThemeStyle = import ./theme-engine/style.nix;

	themeBuilder =
		import ./theme-engine/theme.nix {
			inherit lib colorUtils paletteBuilder defaultThemeStyle themesDir flakeRoot;
		};

	# 3. Modules Engine
	finder = import ./modules/finder.nix {inherit lib;};
	analyzer = import ./modules/analyzer.nix {inherit lib;};

	moduleResolver = finder // analyzer;

	# 4. Overlays & Builders
	pkgsOverlay =
		import ./overlays/custom-pkgs.nix {
			inherit lib inputs flakeRoot;
		};

	varsBuilder =
		import ./builder/vars.nix {
			inherit lib inputs flakeRoot themeBuilder moduleResolver;
		};

	mkHost =
		import ./builder/host.nix {
			inherit lib inputs system flakeRoot themeBuilder moduleResolver varsBuilder pkgsOverlay;
		};
in {
	inherit
		colorUtils
		defaultThemeStyle
		paletteBuilder
		themeBuilder
		moduleResolver
		pkgsOverlay
		varsBuilder
		mkHost
		;
}
