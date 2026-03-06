{ stdenv, config, pkgs, lib, inputs, vars, ... }:
{
	# ========== USER ==========
	users.users.${vars.userName} = {
		isNormalUser = true;
		description = "${vars.userLongName}";
		home = "/home/${vars.userName}";
		shell = pkgs.${vars.shell};
		extraGroups = [
			"networkmanager"
			"wheel"
			"video"
			"audio"
			"input"
			"rtkit"
			"render"
		];
	};
}
