{
	# pkgs,
	...
}: {
	programs.uwsm = {
		enable = true;
		waylandCompositors = {
			scroll = {
				prettyName = "Scroll";
				comment = "Scroll compositor managed by UWSM";
				binPath = "/run/current-system/sw/bin/scroll";
			};
			# niri = {
			# 	prettyName = "Niri";
			# 	comment = "Niri compositor managed by UWSM";
			# 	binPath = "${pkgs.niri}/bin/niri";
			# };
		};
	};
}
