{ lib, config, pkgs, inputs, vars, ... }:
{
	programs = {
		yazi = {
			enable = true;
			plugins = with pkgs.yaziPlugins; {
				sudo = sudo;
				glow = glow;
				piper = piper;
				mount = mount;
				gitui = gitui;
				chmod = chmod;
				miller = miller;
				yatline = yatline;
				mime-ext = mime-ext;
				compress = compress;
				mediainfo = mediainfo;
				toggle-pane = toggle-pane;
				full-border = full-border;
			};
		};
	};
}
