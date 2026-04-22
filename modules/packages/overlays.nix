{inputs, ...}: {
	nixpkgs = {
		config.allowUnfree = true;
	};
	nixpkgs.overlays = [
		# inputs.jbr-wayland-nix.overlays.jbrOverlay
		# (final: prev: {
		# 		jetbrains = with prev;
		# 			jetbrains
		# 			// {
		# 				vmopts = "-Dawt.toolkit.name=WLToolkit";
		# 			};
		# 	})
		# inputs.jbr-wayland-nix.overlays.editorsOverlay
		inputs.niri.overlays.niri
	];
}
