{
	inputs,
	pkgs,
	...
}: {
	nix = {
		package = pkgs.lix;
		settings = {
			auto-optimise-store = true;
			builders-use-substitutes = true;
			warn-dirty = false;
			eval-cache = true;
			experimental-features = ["nix-command" "flakes" "flake-self-attrs"];
			extra-deprecated-features = ["url-literals"];
			substituters = [
				"https://cache.nixos.org/"
				# "https://nix-community.cachix.org"
				"https://niri.cachix.org"
				"https://cache.garnix.io"
			];
			trusted-public-keys = [
				"cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
				# "nix-community.cachix.org-1:mB9FSh9qf2CimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
				"niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
				"cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
			];
		};
	};
	nixpkgs = {
		config.allowUnfree = true;
		overlays = with inputs; [
			# jbr-wayland-nix.overlays.jbrOverlay
			# (final: prev: {
			# 		jetbrains = with prev;
			# 			jetbrains
			# 			// {
			# 				vmopts = "-Dawt.toolkit.name=WLToolkit";
			# 			};
			# 	})
			# jbr-wayland-nix.overlays.editorsOverlay
			niri.overlays.niri
			firefox-addons.overlays.default
		];
	};
}
