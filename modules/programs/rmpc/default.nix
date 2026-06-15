{
	inputs,
	vars,
	...
}:
# let
# keybinds = import ./keybinds.nix {};
# in
{
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {pkgs, ...}: {
			programs.rmpc = {
				enable = true;
				package = inputs.rmpc.packages.${pkgs.stdenv.hostPlatform.system}.default;
				config = ''
					(
						address: "/home/${vars.user.name}/.local/share/mpd/socket",
						cache_dir: Some("/home/${vars.user.name}/Music"),
						extra_yt_dlp_args: "yt-dlp -x --embed-thumbnail --embed-metadata -f bestaudio --convert-thumbnails jpg {} --output <path> <url>",
						on_song_change: None,
						volume_step: 5,
						max_fps: 60,
						scrolloff: 0,
						wrap_navigation: false,
						enable_mouse: true,
						enable_config_hot_reload: true,
						select_current_song_on_change: true,
						browser_song_sort: [Disc, Track, Artist, Title],
					)
				'';
				#  ${keybinds}
			};
		};
	};
}
