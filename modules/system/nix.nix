{
	# stdenv,
	# config,
	# lib,
	# vars,
	inputs,
	pkgs,
	...
}: {
	# ========== NIXPKGS ==========
	nixpkgs = {
		overlays = [inputs.niri.overlays.niri];
		config.allowUnfree = true;
	};
	# ========== NIX ==========
	nix = {
		package = pkgs.lix;
		settings = {
			experimental-features = ["nix-command" "flakes"];

			eval-cache = true;

			substituters = [
				"https://cache.nixos.org/"
				# "https://cache.garnix.io"
			];
			trusted-public-keys = [
				"cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
				# "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
			];
		};
	};
}
