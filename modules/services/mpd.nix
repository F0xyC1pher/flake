{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {lib, ...}: let
			outCfg = vars.hardware.audio.output;
			format = outCfg.format;
			rateStr = toString outCfg.rate.value;

			mpdFormatStr = let
				isFloat32 = (lib.toLower format.prefix == "f") && (format.value == 32);
				fmtVal =
					if isFloat32
					then "f"
					else toString format.value;
			in "${rateStr}:${fmtVal}:*";
		in {
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
					    format "${mpdFormatStr}"
					}
				'';
			};
		};
	};
}
