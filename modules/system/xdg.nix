{
    config,
    pkgs,
    lib,
    vars,
    ...
}:
{
	xdg = {
		terminal-exec = {
			enable = true;
			settings = {
				default = ["kitty.desktop"];
			};
		};
	};
}
