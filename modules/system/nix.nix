{pkgs, ...}: {
	# ========== NIX ==========
	nix = {
		package = pkgs.lix;
		settings = {
			auto-optimise-store = true;
			eval-cache = true;
			experimental-features = ["nix-command" "flakes" "flake-self-attrs"];
			extra-deprecated-features = ["url-literals"];
			substituters = [
				"https://cache.nixos.org/"
				"https://cache.garnix.io"
			];
			trusted-public-keys = [
				"cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
				"cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
			];
		};
	};
}
