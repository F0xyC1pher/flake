{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {pkgs, ...}: {
			programs.yazi = {
				plugins = with pkgs.yaziPlugins; {
					sudo = sudo;
					glow = glow;
					gvfs = gvfs;
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
