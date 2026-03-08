{
	inputs,
	vars,
	pkgs,
	config,
	...
}:
# let
# 	rofi-polkit-script = pkgs.fetchurl {
# 		url = "https://raw.githubusercontent.com/czaplicki/rofi-polkit-agent/master/rofi-polkit-agent";
# 		sha256 = "1lv5m291v45akj7kh2z29sjk8hd36bdf5c1h7saxvl8dkr6jm00y";
# 	};
# 		
# 	rofi-polkit-agent = pkgs.writeShellScriptBin "rofi-polkit-agent" ''
# 		#!/usr/bin/env bash
# 		${builtins.readFile rofi-polkit-script}
# 	'';

	# myBtop = pkgs.btop.overrideAttrs (oldAttrs: rec {
	# 	cmakeFlags = (oldAttrs.cmakeFlags or []) ++ [
	# 		"-DBTOP_GPU=ON"
	# 	];
	# });
	
# in
{
	# imports = [
	# 	./packages/btop-nvidia-gpu.nix	
	# ];
	#==========ENVIRONMENT==========
	environment = {
		
		#==========PACKAGES==========
		systemPackages = with pkgs; [
			(pkgs.callPackage ./packages/aimp.nix { })
			(pkgs.callPackage ./packages/scripts.nix { })
			# rofi-polkit-agent
			# myBtop
		];
	};
}
