{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			programs.rmpc = {
				config = "
					(
						address: \"/tmp/mpd_socket\",
						cache_dir: Some(\"/tmp/rmpc/cache\"),
						on_song_change: None,
						volume_step: 5,
						max_fps: 60,
						scrolloff: 0,
						wrap_navigation: false,
						enable_mouse: true,
						enable_config_hot_reload: true,
						select_current_song_on_change: true,
						browser_song_sort: [Disc, Track, Artist, Title],
						album_art: (
							method: Kitty,
							max_size_px: (600, 600),
						),
					)
				";
			};
		};
	};
	imports=[
		./keybinds.nix
	];
}
