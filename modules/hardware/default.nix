{
	lib,
	vars,
	...
}: let
	hasSwapCfg = vars.host ? swap || vars.host ? zram;
in {
	imports =
		[
			./video
			./boot
			./power.nix
			./redist.nix
			./ssd.nix
		]
		++ lib.optionals (vars.host.hardware.bluetooth.enable or false) [./bluetooth]
		++ lib.optionals (vars.host.parallels.enable or false) [./parallels.nix]
		++ lib.optionals hasSwapCfg [./swap.nix];
}
