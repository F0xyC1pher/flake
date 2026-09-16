{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {lib, ...}: {
			services.mpd = {
				enable = true;
				musicDirectory = "/home/${vars.user.name}/Music";

				extraConfig = ''
					bind_to_address "/home/${vars.user.name}/.local/share/mpd/socket"

					restore_paused "yes"
					max_playlist_length "16384"
					auto_update "yes"
					buffer_before_play "10%"

					audio_output {
					    type "pipewire"
					    name "PipeWire Output"
					    auto_resample "no"
					    # Формат `*:*:*` отключает внутренний ресемплинг MPD
					    # и передает частоту трека прямо в PipeWire
					    format "*:*:*"
					}
				'';
			};
		};
	};
}
