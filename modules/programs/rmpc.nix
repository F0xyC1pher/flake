{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {pkgs, ...}: {
			programs.rmpc = {
				enable = true;
				package = pkgs.rmpc;
				config = "
					(
						address: \"/tmp/mpd_socket\",
						password: None,
						theme: None,
						cache_dir: Some(\"/tmp/rmpc/cache\"),
						on_song_change: None,
						volume_step: 5,
						max_fps: 60,
						scrolloff: 0,
						wrap_navigation: false,
						enable_mouse: true,
						enable_config_hot_reload: true,
						status_update_interval_ms: 1000,
						select_current_song_on_change: true,
						browser_song_sort: [Disc, Track, Artist, Title],
					)
				";
			};
		};
	};
}
