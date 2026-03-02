{
	config,
	pkgs,
	lib,
	inputs,
	vars,
	...
}: {
	imports = [
		./binds.nix
		./window-rules.nix
	];
	# ========== NIRI ==========
	programs.niri = {
		settings = {
			clipboard.disable-primary = false;
			screenshot-path = "~/CoolStuff/Pictures/Screenshots/%Y-%m-%d %H:%M:%S.png";
			input = {
				focus-follows-mouse.enable = true;
				mod-key = "Super";
				keyboard.repeat-delay = 450;
				keyboard.repeat-rate = 30;
				keyboard.xkb = {
					layout = "us,ru";
					options = "grp:alt_shift_toggle";
				};
			};
			
			outputs = {
				"DVI-D-1" = {
					enable = true;
					variable-refresh-rate = false;
					scale = 1;

					mode = {
						width = 1600;
						height = 900;
						refresh = 60.000;
					};
					position = {
						x = 0;
						y = 0;
					};
					
					transform = {
						flipped = false;
						rotation = 0;
					};
				};
			};
			
			layout = {
				focus-ring.enable = false;
				border = {
					enable = true;
					width = 4;
					active.color = "#d76667";
					inactive.color = "#363636";
				};
				gaps = 30;
				struts = {
					left = 10;
					top = -10;
					right = 10;
					bottom = -10;
				};
			};
		};
	};
}
