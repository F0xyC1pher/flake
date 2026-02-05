{ config, pkgs, lib, inputs, vars, ... }:
{
	# ========== BLUETOOTH ==========
	hardware = {
		bluetooth = {
			enable = true;
			powerOnBoot = true;
			settings = {
				General = {
					Experimental = true;
					FastConnectable = true;	
				};
				Policy = {
					AutoEnable = true;
				};
			};
		};
	};
}
