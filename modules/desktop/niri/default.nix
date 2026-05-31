{
  pkgs,
  inputs,
  vars,
  ...
}:
{
  # systemd.user.services.niri-flake-polkit.enable = false;
  programs.niri.enable = true;
  imports = [
    ./config
  ];
  home-manager = {
    extraSpecialArgs = { inherit inputs vars; };
    users.${vars.user.name} =
      {
        pkgs,
        lib,
        ...
      }:
      {
        # ========== NIRI ==========
        # programs.niri = {
        #   package = pkgs.niri-unstable;
        # };

        # home.activation.reloadNiri = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        #   					if command -v niri >/dev/null 2>&1; then
        #   					niri msg action reload-config 2>/dev/null || true
        #   					fi
        #   				'';
      };
  };
}
