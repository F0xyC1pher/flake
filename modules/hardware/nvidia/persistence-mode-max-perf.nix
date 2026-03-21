{ config, pkgs, lib, ... }:

let
  nvidiaSmi = "${config.hardware.nvidia.package}/bin/nvidia-smi";
in
{
  systemd.services.nvidia-auto = {
    description = "NVIDIA auto power setup";

    wantedBy = [ "multi-user.target" ];
    after = [ "multi-user.target" ];

    serviceConfig.Type = "oneshot";

    script = ''
      set -e

      ${nvidiaSmi} -pm 1 || true

      for gpu in $(${nvidiaSmi} --query-gpu=index --format=csv,noheader); do
        max_limit=$(${nvidiaSmi} -i $gpu --query-gpu=power.max_limit --format=csv,noheader | tr -d ' ')
		${nvidiaSmi} -i $gpu -pl $max_limit || true
        ${nvidiaSmi} -i $gpu --lock-gpu-clocks=0,0 || true
      done
    '';
  };
}
