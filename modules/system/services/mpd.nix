{vars, ...}: {
	services.mpd = {
		enable = true;
		user = "${vars.userName}";
		openFirewall = true;
		startWhenNeeded = true;
		settings = {
			music_directory = "/home/${vars.userName}/Music";

			bind_to_address = "any"; # если хочешь разрешить подключения не только с localhost
			port = 6600;

			# Основные настройки
			restore_paused = "yes";
			max_playlist_length = "16384";
			auto_update = "yes";
			# auto_update_depth = "3";

			# Настройки буферизации
			buffer_before_play = "10%";

			# ReplayGain для единообразия громкости
			replaygain = "album";
			replaygain_preamp = "0";

			# Качество ресемплинга MPD (если вдруг понадобится)
			# Но лучше доверить это PipeWire
			# samplerate_converter = "soxr very high";
			audio_output = [
				{
					type = "pipewire";
					name = "PipeWire Output";
					format = "192000:32:2";
					mixer_type = "software";
					auto_resample = "no";
					buffer_time = "50000";
					period_time = "16384";
					# Оптимизация для низкой задержки
					# sync = "no";  # если нужна минимальная задержка
				}
			];
		};
	};
	systemd.services.mpd = {
		environment = {
			# https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
			XDG_RUNTIME_DIR = "/run/user/1000"; # User-id 1000 must match above user. MPD will look inside this directory for the PipeWire socket.
		};
		serviceConfig = {
			# Приоритет процесса MPD
			Nice = -5;
			CPUSchedulingPolicy = "rr";
			CPUSchedulingPriority = 85;
			# Ядра для звука (из ваших cpu.affinity = [2 3 6 7])
			CPUAffinity = [6 7];
			# Ограничения памяти
			# MemoryMax = "512M";
			# MemoryHigh = "256M";
			# IO приоритет
			IOSchedulingClass = "realtime";
			IOWeight = 100;
		};
	};
}
