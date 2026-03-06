{
    config,
    pkgs,
    lib,
    vars,
    ...
}:
{
	xdg = {
		mime.enable = true;
		mime.defaultApplications = {
			"inode/directory" = [ "yazi.desktop" ];
		};
	};
}
