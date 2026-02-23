{
	inputs,
	vars,
	pkgs,
	config,
	...
}:
let
	rofi-polkit-script = pkgs.fetchurl {
		url = "https://raw.githubusercontent.com/czaplicki/rofi-polkit-agent/master/rofi-polkit-agent";
		sha256 = "1lv5m291v45akj7kh2z29sjk8hd36bdf5c1h7saxvl8dkr6jm00y";
	};
		
	rofi-polkit-agent = pkgs.writeShellScriptBin "rofi-polkit-agent" ''
		#!/usr/bin/env bash
		${builtins.readFile rofi-polkit-script}
	'';
in
{
	#==========ENVIRONMENT==========
	environment = {
		
		#==========PACKAGES==========
		systemPackages = with pkgs; [
			(pkgs.callPackage ./packages/aimp.nix { })
			(pkgs.callPackage ./packages/scripts.nix { })
			rofi-polkit-agent
		];
	};
	
	home-manager.users.${vars.userName} = { config, pkgs, lib, ... }: {
		# home.packages = with pkgs; [
		# ];
		
		systemd.user.services.rofi-polkit-agent = {
			Unit = {
				Description = "Rofi-based Polkit Authentication Agent";
				After = [ "graphical-session.target" ];
				Wants = [ "graphical-session.target" ];
			};
			
			Service = {
				Type = "simple";
				ExecStart = "${rofi-polkit-agent}/bin/rofi-polkit-agent";
				Restart = "on-failure";
				RestartSec = 3;
			};
			
			Install = {
				WantedBy = [ "graphical-session.target" ];
			};
		};
	};
}
