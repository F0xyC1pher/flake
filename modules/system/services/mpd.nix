{vars, ...}: {
	services.mpd = {
		enable = true;
		user = "${vars.userName}";
		settings = {
			music_directory = "/home/${vars.userName}/CoolStuff/Music";

			# Вот как теперь задаётся audio_output (это список, можно несколько блоков)
			audio_output = [
				{
					type = "pipewire";
					name = "PipeWire Output";
					# Дополнительные параметры, если нужно (опционально):
					# format = "44100:16:2";      # пример
					# mixer_type = "software";
					# auto_resample = "no";
				}
			];
			# Если нужны другие простые параметры (не блоки), пиши их прямо здесь:
			# restore_paused = "yes";
			# max_playlist_length = "16384";
		};
		# network = {
		#     listenAddress = "any";          # если хочешь разрешить подключения не только с localhost
		#   };
		# Optional:
		#	network.listenAddress = "any"; # if you want to allow non-localhost connections
		startWhenNeeded = true; # systemd feature: only start MPD service upon connection to its socket
	};
	systemd.services.mpd.environment = {
		# https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
		XDG_RUNTIME_DIR = "/run/user/1000"; # User-id 1000 must match above user. MPD will look inside this directory for the PipeWire socket.
	};
}
