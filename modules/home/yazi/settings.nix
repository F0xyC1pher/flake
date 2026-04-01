{
	# lib,
	# config,
	# pkgs,
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {
			config,
			# pkgs,
			# lib,
			...
		}: {
			programs.yazi = {
				settings = {
					mgr = {
						ratio = [
							1
							4
							3
						];
						sort_by = "natural";
						sort_sensitive = true;
						sort_reverse = false;
						sort_dir_first = true;
						linemode = "none";
						show_hidden = true;
						show_symlink = true;
					};

					preview = {
						max_width = 1200;
						max_height = 900;
						image_quality = 90;
						cache_dir = "${config.xdg.cacheHome}/yazi";
					};

					tasks = {
						micro_workers = 5;
						macro_workers = 10;
						bizarre_retry = 5;
					};

					plugin = {
						prepend_fetchers = [
							{
								id = "mime";
								url = "local://*";
								run = "mime-ext.local";
								prio = "high";
							}
							{
								id = "mime";
								url = "remote://*";
								run = "mime-ext.remote";
								prio = "high";
							}
						];
						prepend_previewers = [
							{
								name = "*.md";
								run = "glow";
							}
						];
					};
				};
			};
		};
	};
}
