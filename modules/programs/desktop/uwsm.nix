{
	pkgs,
	lib,
	inputs,
	vars,
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

				"niri" =
					lib.mkIf (vars.hasProgram "niri") {
						prettyName = "Niri";
						binPath = "${lib.getExe inputs.niri-glass.packages.x86_64-linux.default}";
						extraArgs = [
							"--session"
						];
					};

				"hyprland" =
					lib.mkIf (vars.hasProgram "hyprland") {
						prettyName = "Hyprland";
						binPath = ''${lib.getExe' inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland "start-hyprland"}'';
					};
			};
		};
	};
}
