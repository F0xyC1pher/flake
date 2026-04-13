{
	config,
	pkgs,
	vars,
	...
}: let
	ne = vars.hardware.nvidia.enable;
	# Берем тот же пакет, который вы определили для драйвера
	nvidiaPkg = config.boot.kernelPackages.nvidiaPackages.legacy_580;
in {
	# Включаем сервис только если NVIDIA включена в vars
	systemd.services.nvidia-auto = {
		description = "NVIDIA auto power setup";

		# Условие запуска: только если включена настройка в vars
		enable = ne;

		wantedBy = ["multi-user.target"];
		after = ["multi-user.target"];

		serviceConfig = {
			Type = "oneshot";
			RemainAfterExit = true;
		};

		# Ключевой момент: прокидываем пути к бинарникам
		path = [
			nvidiaPkg.bin # Здесь лежит nvidia-smi
			pkgs.coreutils # Здесь лежит tr и echo
		];

		script = ''
			set -euo pipefail

			echo "Enabling Persistence Mode..."
			nvidia-smi -pm 1 || true

			# Получаем список индексов GPU
			for gpu in $(nvidia-smi --query-gpu=index --format=csv,noheader); do
			  echo "Processing GPU $gpu..."

			  # Получаем лимит, убираем пробелы и символ 'W'
			  MAX_LIMIT=$(nvidia-smi -i "$gpu" --query-gpu=power.max_limit --format=csv,noheader | tr -d ' W')

			  if [ -z "$MAX_LIMIT" ] || [ "$MAX_LIMIT" = "N/A" ]; then
			    echo "Power limit for GPU $gpu is not available, skipping."
			  else
			    echo "Setting power limit to $MAX_LIMIT W"
			    nvidia-smi -i "$gpu" -pl "$MAX_LIMIT" || true
			  fi

			  echo "Resetting clock locks..."
			  nvidia-smi -i "$gpu" --lock-gpu-clocks=0,0 > /dev/null 2>&1 || true
			done
		'';
	};
}
