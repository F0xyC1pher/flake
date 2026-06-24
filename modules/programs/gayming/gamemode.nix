{pkgs, ...}: {
	programs.gamemode = {
		enable = true;

		settings = {
			custom = {
				# При старте игры → lavd
				start = "${pkgs.scxctl}/bin/scxctl switch -s scx_lavd -m Gaming";
				# При завершении игры → rusty
				stop = "${pkgs.scxctl}/bin/scxctl switch -s scx_rusty -m Auto";
			};
		};
	};
}
