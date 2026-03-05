{ lib, pkgs, inputs, vars, ... }:

let
  powerMizerMode = 1;
in
{
  home-manager = {
    extraSpecialArgs = { inherit inputs vars; };

    users.${vars.userName} = { config, pkgs, lib, ... }: {

      # Импортируем сервис прямо здесь
      systemd.user.services.nvidia-auto = {
        description = "Automatic NVIDIA settings on Wayland/X: Persistence Mode, Max Power, PowerMizer if X available";
        after = [ "graphical-session.target" ];
        serviceConfig.Type = "oneshot";

        serviceConfig.ExecStart = ''
          # Включаем Persistence Mode для всех NVIDIA GPU
          ${pkgs.nvidia-x11}/bin/nvidia-smi -pm 1

          # Для каждой NVIDIA GPU устанавливаем Power Limit на максимум
          for gpu in $(${pkgs.nvidia-x11}/bin/nvidia-smi --query-gpu=index --format=csv,noheader); do
            max_limit=$(${pkgs.nvidia-x11}/bin/nvidia-smi -i $gpu --query-gpu=power.limit --format=csv,noheader | head -n1)
            ${pkgs.nvidia-x11}/bin/nvidia-smi -i $gpu -pl $max_limit
          done

          # Если X-сессия активна, применяем PowerMizerMode
          if [ -n "$DISPLAY" ]; then
            for gpu in $(${pkgs.nvidia-x11}/bin/nvidia-smi --query-gpu=index --format=csv,noheader); do
              ${pkgs.nvidia-x11}/bin/nvidia-settings -a "[gpu:${gpu}]/GPUPowerMizerMode=${powerMizerMode}"
            done
          fi
        '';

        install.wantedBy = [ "default.target" ];
      };

      # Дополнительно пакеты пользователя, если нужно
      home.packages = [];
    };
  };
}
