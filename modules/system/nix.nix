{pkgs, ...}: {
	# ========== NIX ==========
	nix = {
		package = pkgs.lix;
		settings = {
			auto-optimise-store = true;
			warn-dirty = false;
			eval-cache = true;
			experimental-features = ["nix-command" "flakes" "flake-self-attrs"];
			extra-deprecated-features = ["url-literals"];
			substituters = [
				"https://cache.nixos.org/"
				"https://nix-community.cachix.org"
				"https://niri.cachix.org"
				"https://cache.garnix.io"
			];
			trusted-public-keys = [
				"cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
				"nix-community.cachix.org-1:mB9FSh9qf2dde0enV10nba62DosErc9j60RbDddiqwg="
				"niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
				"cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
			];
		};
	};
}
