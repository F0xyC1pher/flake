{ lib, config, pkgs, inputs, vars, ... }:
{
	home-manager = {
		extraSpecialArgs = { inherit inputs vars; };
		users.${vars.userName} =  { config, pkgs, lib, ... }: {
		programs.waybar = {
			style = ''
				* {
					font-family: FiraCode Nerd Font Mono, SourceHanSansJP;
					font-weight: 600;
					font-size: 16px;
					border-radius: 0px;
				}

				window#waybar {
					background: transparent;
					color: #d6d6d6;
				}

				window#waybar > box {
					background: #161616;
					border-bottom: 1px solid #363636;
					padding: 0 8px;
				}
		    
			/*	===================================
						COMMON MODULE STYLE
				===================================	*/
		    
				#battery,
				#backlight,
				#clock,
				#wireplumber,
				#bluetooth,
				#language,
				#custom-clock,
				#tray {
					border: 1px solid #464646;
					background: #363636;
					color: #d6d6d6;
					padding: 0 10px;
					margin: 3px 4px;
					min-height: 28px;
				}

			/*	===================================
					COMMON MODULE STYLE :hover
				===================================	*/
			         
				#battery:hover,
				#backlight:hover,
				#clock:hover,
				#wireplumber:hover,
				#bluetooth:hover,
				#language:hover,
				#custom-clock:hover,
				#tray:hover {
					border: 1px solid #666666;
					background: #565656;
					color: #f6f6f6;
					padding: 0 10px;
					margin: 3px 4px;
					min-height: 28px;
					transition: all 0.2s ease;
				}
				
			/*	===================================
							WORKSPACES
				===================================	*/
		    
				#workspaces {
					border: none;
					background: transparent;
					margin: 3px 4px;
				}
		    
				#workspaces button {
					border-bottom: none;
					border: 1px solid #464646;
					background: #363636;
					margin: 0 3px;
					padding: 0 10px;
					color: #d6d6d6;
					min-height: 28px;
				}

				#workspaces button.empty {
					border: 1px solid transparent;
					color: #d6d6d6;
					background: transparent;
				}

				#workspaces button.active {
					border: 1px solid #d76667;
					background: #d76667;
					color: #060606;
					border-bottom-width: 1px;
					border-bottom-color: #d76667;
				}
				
				#workspaces button.active:hover {
					border: 1px solid #f6f6f6;
					background: #d76667;
					color: #060606;
					border-bottom-width: 1px;
					border-bottom-color: #f6f6f6;
					transition: all 0.2s ease;
				}

				#workspaces button:hover {
					border: 1px solid #666666;
					background: #565656;
					color: #f6f6f6;
					transition: all 0.2s ease;
				}
				
			/*	===================================
							GTK FIX	
				===================================	*/
				
				/*
				#workspaces button,
				#workspaces button:focus,
				#workspaces button:active,
				#workspaces button:checked,
				#workspaces button.active {
					outline: 0 ;
					box-shadow: none;
					border-image: none;
				}
				*/
		      
			/*	===================================
							STATE COLORS	
				===================================	*/    
		    
				#battery.warning {
					border-color: #d7a766;
				}

				#battery.critical {
					border-color: #d76667;
				}

				#wireplumber.muted {
					color: #888888;
				}

			'';
		};
	};
	};
}
