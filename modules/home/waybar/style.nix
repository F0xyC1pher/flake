{ lib, config, pkgs, inputs, vars, ... }:
{
	programs.waybar = {
		style = ''
			* {
				border: none;
				border-radius: 0;
				font-family: "FiraCode Nerd Font Mono";
				font-weight: bold;
				font-size: 14px;
				min-height: 0;
			}
			
			window#waybar {
				background: #060606;
				color: #f6f6f6;
			}
			
			#custom-launcher {
				padding: 0 10px 0 12px;
				color: #61d6d6;
				font-size: 20px;
			}
			
			#custom-launcher:hover {
				background: #363636;
			}
			
			#workspaces button {
				padding: 0 8px;
				color: #d6d6d6;
				background: transparent;
			}
			
			#workspaces button:hover {
				background: #363636;
			}
			
			#workspaces button.active {
				color: #88C0D0;
				background: #363636;
			}
			
			#workspaces button.focused {
				color: #d76667;
				background: #363636;
				font-weight: bold;
			}
			
			#workspaces button.empty {
				color: #767676;
			}
			
			#workspaces button.current_output {
				opacity: 1;
			}
			
			#workspaces button:not(.current_output) {
				opacity: 0.6;
			}
			
			#window {
				padding: 0 15px;
				color: #88C0D0;
				font-weight: bold;
				font-style: italic;
			}
			
			window#waybar.empty #window {
				background-color: transparent;
				color: #767676;
				font-style: normal;
			}
			
			window#waybar.solo #window {
				color: #A3BE8C;
			}
			
			#tray, #language, #pulseaudio, #network, #cpu, #memory, #clock {
				padding: 0 10px;
			}
			
			#language {
				color: #B48EAD;
				background: #2E3440;
			}
			
			#language:hover {
				background: #3B4252;
			}
			
			#pulseaudio {
				color: #EBCB8B;
			}
			
			#pulseaudio.muted {
				color: #4C566A;
			}
			
			#network {
				color: #81A1C1;
			}
			
			#network.disconnected {
				color: #BF616A;
			}
			
			#cpu {
				color: #D08770;
			}
			
			#memory {
				color: #A3BE8C;
			}
			
			#clock {
				color: #88C0D0;
				font-weight: bold;
			}
			
			#tray {
				color: #5E81AC;
			}
			
			#tray > .passive {
				-gtk-icon-effect: dim;
			}
			
			#tray > .needs-attention {
				-gtk-icon-effect: highlight;
				color: #BF616A;
			}
		'';
	};
}
