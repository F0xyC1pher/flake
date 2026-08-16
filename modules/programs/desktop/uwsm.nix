{
	pkgs,
	lib,
	inputs,
	...
}: {
	programs = {
		uwsm = {
			enable = true;
			waylandCompositors = {
				"gamescope" = {
					prettyName = "Gamsescope";
					binPath = "${lib.getExe pkgs.gamescope}";
					extraArgs = [
						"-e"
					];
				};

				"niri" = {
					prettyName = "Niri";
					binPath = "${lib.getExe inputs.niri-glass.packages.x86_64-linux.default}";
					extraArgs = [
						"--session"
					];
				};

				"hyprland" = {
					prettyName = "Hyprland";
					binPath = ''${lib.getExe' pkgs.hyprland "start-hyprland"}'';
				};
			};
		};
	};
}
