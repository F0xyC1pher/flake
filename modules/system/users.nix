{
	pkgs,
	vars,
	...
}: {
	# ========== USER ==========
	users.users.${vars.userName} = {
		isNormalUser = true;
		description = "${vars.userFullName}";
		home = "/home/${vars.userName}";
		shell = pkgs.${vars.shell};
		extraGroups = [
			"networkmanager"
			"wheel"
			"video"
			"audio"
			"pipewire"
			"input"
			"rtkit"
			"realtime"
			"adbusers"
			"render"
			"games"
			"gamemode"
			"mpd"
			"cdrom"
			"disk"
			"floppy"
			"kmem"
		];
	};
}
