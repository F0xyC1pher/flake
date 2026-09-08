{
	lib,
	vars,
	...
}: let
	ramGb = vars.host.hardware.ram or null;
	hasRam = ramGb != null;

	swapCfg = vars.host.swap or {};
	swapSizeGb = swapCfg.size or ramGb;

	hasSwapFile =
		if swapCfg ? enable
		then swapCfg.enable && (swapSizeGb != null)
		else (vars.host ? swap && swapSizeGb != null);

	zramCfg = vars.host.zram or {};

	calculatedPercent =
		if !hasRam
		then 50
		else if ramGb <= 4
		then 200
		else if ramGb <= 8
		then 150
		else if ramGb <= 16
		then 100
		else if ramGb <= 32
		then 50
		else 0;

	zramPercent = zramCfg.percent or calculatedPercent;

	hasZram =
		if zramCfg ? enable
		then zramCfg.enable
		else (vars.host ? zram);
in {
	swapDevices =
		lib.optionals hasSwapFile [
			{
				device = "/var/lib/swapfile";
				size = swapSizeGb * 1024;
				priority = 10;
				noCoW = true;
			}
		];

	boot.zswap.enable =
		if hasZram
		then false
		else (lib.mkIf hasSwapFile true);

	zramSwap = {
		enable = hasZram;
		algorithm = "zstd";
		memoryPercent =
			if hasZram
			then zramPercent
			else 0;
		priority = 100;
	};
}
