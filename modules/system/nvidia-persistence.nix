{ config, pkgs, lib, ... }:

let
  nvidia = config.hardware.nvidia.package;
in
{
  systemd.services.nvidia-auto = {
    description = "NVIDIA auto power setup";

    wantedBy = [ "multi-user.target" ];
    after = [ "multi-user.target" ];

    serviceConfig.Type = "oneshot";

    path = [
      nvidia
      pkgs.coreutils
      pkgs.gnugrep
    ];

    script = ''
      set -e

      nvidia-smi -pm 1

      for gpu in $(nvidia-smi --query-gpu=index --format=csv,noheader); do
        max_limit=$(nvidia-smi -i $gpu --query-gpu=power.limit --format=csv,noheader,nounits)
        nvidia-smi -i $gpu -pl $max_limit
      done
    '';
  };
}
