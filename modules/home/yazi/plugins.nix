{ lib, config, pkgs, inputs, vars, ... }:
{
	home-manager = {
		extraSpecialArgs = { inherit inputs vars; };
		users.${vars.userName} =  { config, pkgs, lib, ... }: {
			programs.yazi = {
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
	};
}
