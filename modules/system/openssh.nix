{ stdenv, config, pkgs, lib, inputs, vars, ... }:
{
	services.openssh = {
		enable = true;
	};
}
