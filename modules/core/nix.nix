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
				"https://noctalia.cachix.org"
				"https://nix-community.cachix.org"
				"https://niri.cachix.org"
				"https://cache.nixos.org"
				"https://cache.garnix.io"
				"https://freesmlauncher.cachix.org"
			];
			trusted-public-keys = [
				"hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
				"noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
				"nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
				"niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
				"cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
				"cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
				"freesmlauncher.cachix.org-1:Jcp5Q9wiLL+EDv8Mh7c6L9xGk+lXr7/otpKxMOuBuDs="
			];
			extra-substituters = [
				"https://yazi.cachix.org"
			];
			extra-trusted-public-keys = [
				"yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
			];
		};
	};
}
