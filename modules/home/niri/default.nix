{
  # config,
  # lib,
  pkgs,
  inputs,
  vars,
  ...
}:
{
  systemd.user.services.niri-flake-polkit.enable = false;
  programs.niri.enable = true;
  environment.systemPackages = with pkgs; [
    niri-unstable
    xwayland-satellite-unstable
  ];
        imports = [
			    ./config
        ];
  home-manager = {
    extraSpecialArgs = { inherit inputs vars; };
    users.${vars.userName} =
      {
        # config,
        pkgs,
        lib,
        ...
      }:
      {
        # ========== NIRI ==========
        programs.niri = {
          package = pkgs.niri-unstable;
        };

        home.activation.reloadNiri = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          		if command -v niri >/dev/null 2>&1; then
          		niri msg action reload-config 2>/dev/null || true
          		fi
          	'';
      };
  };
}
