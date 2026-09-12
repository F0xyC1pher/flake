{
	inputs,
	vars,
	...
}: {
	imports = [
		./theme.nix
	];
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: {
			programs.rofi = {
				enable = true;
				terminal = "kitty";
				extraConfig = {
					modi = "run,drun,window";
					icon-theme = "Flat-Remix-Red-Dark";
					show-icons = true;
					terminal = "kitty";
					drun-display-format = "{icon} {name}";
					location = 0;
					hide-scrollbar = true;
					display-drun = "   Apps ";
					display-run = "   Run ";
					display-window = " 󰕰  Window ";
					sidebar-mode = true;
					disable-history = true;
					cycle = true;
					filebrowser = {
						directories-first = true;
						sorting-method = "name";
					};
					timeout = {
						action = "kb-cancel";
						delay = 0;
					};
				};
			};
		};
	};
}
