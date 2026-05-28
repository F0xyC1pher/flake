{
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
      # extra-deprecated-features = ["url-literals"];
      substituters = [
        "https://cache.garnix.io"
        "https://nix-community.cachix.org"
        "https://niri.cachix.org"
        "https://cache.nixos.org"
      ];
      trusted-public-keys = [
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
    };
  };
  nixpkgs = {
    config.allowUnfree = true;
    overlays = with inputs; [
      niri.overlays.niri
      nix-firefox-addons.overlays.default
    ];
  };
}
