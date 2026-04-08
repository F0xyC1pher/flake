{pkgs, ...}: {
	services.gvfs.enable = true;
	services.gvfs.package = pkgs.gvfs;
}
