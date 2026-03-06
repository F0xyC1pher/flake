{ config, pkgs, lib, vars, ... }:

let
  nvidia = config.boot.kernelPackages.nvidia_x11;
  bash = pkgs.bash;
  powerMizerMode = "1";
in
{
  home-manager.users.${vars.userName} = { config, pkgs, lib, ... }: {

    systemd.user.services.nvidia-auto = {
      description = "Automatic NVIDIA: Persistence Mode + Max Power + PowerMizer if X";

      # Тип единичного запуска
      serviceConfig = {
        Type = "oneshot";
      };

      # Скрипт для ExecStart
      script = ''
        ${nvidia}/bin/nvidia-smi -pm 1
        for gpu in $(${nvidia}/bin/nvidia-smi --query-gpu=index --format=csv,noheader); do
          max_limit=$(${nvidia}/bin/nvidia-smi -i $gpu --query-gpu=power.limit --format=csv,noheader | head -n1)
          ${nvidia}/bin/nvidia-smi -i $gpu -pl $max_limit
        done

        if [ -n "$DISPLAY" ]; then
          for gpu in $(${nvidia}/bin/nvidia-smi --query-gpu=index --format=csv,noheader); do
            ${nvidia}/bin/nvidia-settings -a '[gpu:'"$gpu"']/GPUPowerMizerMode=${powerMizerMode}'
          done
        fi
      '';

      # Зависимость от graphical session
      after = [ "graphical-session.target" ];
    };
  };
}
