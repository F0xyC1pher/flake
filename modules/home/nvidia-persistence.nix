{ config, pkgs, lib, inputs, vars, ... }:

let
  nvidia = config.boot.kernelPackages.nvidia_x11;
  bash = pkgs.bash;
  powerMizerMode = "1";  # теперь строка
in
{
  home-manager = {
    extraSpecialArgs = { inherit inputs vars; };

    users.${vars.userName} = { config, pkgs, lib, ... }: {

      systemd.user.services.nvidia-auto = {
        serviceConfig = {
          Description = "Automatic NVIDIA: Persistence Mode + Max Power + PowerMizer if X";
          Type = "oneshot";
          After = "graphical-session.target";

          ExecStart = "${bash}/bin/bash -c ''
${nvidia}/bin/nvidia-smi -pm 1
for gpu in \$(${nvidia}/bin/nvidia-smi --query-gpu=index --format=csv,noheader); do
  max_limit=\$(${nvidia}/bin/nvidia-smi -i \$gpu --query-gpu=power.limit --format=csv,noheader | head -n1)
  ${nvidia}/bin/nvidia-smi -i \$gpu -pl \$max_limit
done

if [ -n \"\$DISPLAY\" ]; then
  for gpu in \$(${nvidia}/bin/nvidia-smi --query-gpu=index --format=csv,noheader); do
    ${nvidia}/bin/nvidia-settings -a \"[gpu:\$gpu]/GPUPowerMizerMode=${powerMizerMode}\"
  done
fi
''";
        };

        install = {
          WantedBy = [ "default.target" ];
        };
      };

      home.packages = [];
    };
  };
}
