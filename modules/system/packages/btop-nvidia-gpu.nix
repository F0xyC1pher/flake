{ pkgs, config, ... }:

let
  btop-with-gpu = pkgs.btop.overrideAttrs (oldAttrs: rec {
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [
      pkgs.nvidia_x11.libnvidia-ml
    ];
    cmakeFlags = (oldAttrs.cmakeFlags or []) ++ [
      "-DBTOP_GPU=ON"
    ];
  });
in
{
  environment.systemPackages = [
    btop-with-gpu
  ];

  systemd.services.btop = {
    description = "btop++ with GPU access";
    after = [ "network.target" ];
    serviceConfig = {
      ExecStart = "${btop-with-gpu}/bin/btop";
      AmbientCapabilities = "CAP_SYS_ADMIN";
      NoNewPrivileges = false;
    };
    wantedBy = [ "multi-user.target" ];  # <-- исправлено
  };
}
