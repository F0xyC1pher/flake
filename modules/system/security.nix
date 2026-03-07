{ stdenv, config, pkgs, lib, inputs, vars, ... }:
{
	security = {
		sudo.wheelNeedsPassword = false;
		rtkit.enable = true;
		polkit.enable = true;
	};
}
