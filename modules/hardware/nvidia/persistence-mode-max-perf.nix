{
	pkgs,
	config,
	vars,
	...
}: let
	ne = vars.hardware.nvidia.enable;
	persistence = vars.hardware.nvidia.perf.persistence;
	perf = vars.hardware.nvidia.perf.value;
	nvidiaPkg = config.boot.kernelPackages.nvidiaPackages.${vars.hardware.nvidia.package};

	enableService = ne && (persistence == true || (perf != null && perf != false));
in {
	systemd.services.nvidia-auto = {
		description = "NVIDIA auto power setup";
		enable = enableService;
		wantedBy = ["multi-user.target"];
		after = ["multi-user.target"];

		serviceConfig = {
			Type = "oneshot";
			RemainAfterExit = true;
		};

		path = [
			nvidiaPkg.bin
			pkgs.coreutils
			pkgs.bc
			pkgs.gnused # для sed
		];

		script = ''
			set -euo pipefail

			# ---------- Persistence Mode ----------
			${
				if persistence == true
				then ''
					echo "Enabling Persistence Mode..."
					nvidia-smi -pm 1 || true
				''
				else ''
					echo "Persistence mode not requested, skipping."
				''
			}

			# ---------- Power Limit ----------
			${
				if perf != null && perf != false
				then ''
					for gpu in $(nvidia-smi --query-gpu=index --format=csv,noheader); do
					  echo "Processing GPU $gpu..."
					  # Получаем сырое значение, удаляем пробелы, W, \r, \n
					  MAX_LIMIT_RAW=$(nvidia-smi -i "$gpu" --query-gpu=power.max_limit --format=csv,noheader | tr -d ' W\r\n')
					  if [ -z "$MAX_LIMIT_RAW" ] || [ "$MAX_LIMIT_RAW" = "N/A" ]; then
					    echo "Power limit for GPU $gpu is not available, skipping."
					    continue
					  fi
					  # Извлекаем только число (целое или дробное)
					  MAX_LIMIT_NUM=$(echo "$MAX_LIMIT_RAW" | grep -oE '[0-9]+\.?[0-9]*' | head -1)
					  if [ -z "$MAX_LIMIT_NUM" ]; then
					    echo "Could not parse power limit value: '$MAX_LIMIT_RAW', skipping."
					    continue
					  fi
					  # Отбрасываем дробную часть (нужны целые ватты)
					  MAX_LIMIT=''${MAX_LIMIT_NUM%.*}

					  ${
						if builtins.isInt perf || builtins.isFloat perf
						then ''
							DESIRED_LIMIT="${toString perf}"
							echo "Setting power limit to $DESIRED_LIMIT W (from config)"
							nvidia-smi -i "$gpu" -pl "$DESIRED_LIMIT" || true
						''
						else if builtins.isString perf
						then ''
							PERCENT="${perf}"
							PERCENT=$(echo "$PERCENT" | sed 's/%//')
							if ! [[ "$PERCENT" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
							  echo "Invalid percent value: $PERCENT, skipping."
							else
							  DESIRED_LIMIT=$(echo "scale=0; $MAX_LIMIT * $PERCENT / 100" | bc)
							  if [ "$DESIRED_LIMIT" -lt 1 ]; then
							    DESIRED_LIMIT=1
							  fi
							  echo "Setting power limit to $DESIRED_LIMIT W (''${PERCENT}% of ''${MAX_LIMIT}W)"
							  nvidia-smi -i "$gpu" -pl "$DESIRED_LIMIT" || true
							fi
						''
						else ''
							# perf == true
							echo "Setting power limit to $MAX_LIMIT W (max available)"
							nvidia-smi -i "$gpu" -pl "$MAX_LIMIT" || true
						''
					}

					  # Сброс блокировки частот
					  echo "Resetting clock locks..."
					  nvidia-smi -i "$gpu" --lock-gpu-clocks=0,0 > /dev/null 2>&1 || true
					done
				''
				else ''
					echo "Power limit adjustment not requested, skipping."
				''
			}
		'';
	};
}
