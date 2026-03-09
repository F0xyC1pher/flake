{ lib, config, pkgs, inputs, vars, ... }:
{
	home-manager = {
		extraSpecialArgs = { inherit inputs vars; };
		users.${vars.userName} =  { config, pkgs, lib, ... }: {
			programs.yazi = {
				settings = {
									
					manager = {
						show_hidden = true;
						sort_by = "natural";
						sort_dir_first = true;
					};
					
					preview = {
						max_width = 1200;
						max_height = 900;
						cache_dir = "${config.xdg.cacheHome}/yazi";
					};
					
					plugin = {
						prepend_fetchers = [
							{ id = "mime"; url = "local://*"; run = "mime-ext.local"; prio = "high"; }
							{ id = "mime"; url = "remote://*"; run = "mime-ext.remote"; prio = "high"; }
						];
						prepend_previewers = [
							{ name = "*.md"; run = "glow"; }
						];
					};
				};
			};
		};
	};
}
