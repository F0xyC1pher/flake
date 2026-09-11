{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: {
			programs.yazi = {
				keymap = {
					mgr = {
						prepend_keymap = [
							{
								on = ["<Esc>"];
								run = "close";
								desc = "Cancel input";
							}
							{
								on = ["!"];
								run = "shell \"$SHELL\" --block";
								desc = "Open $SHELL here";
							}
							{
								on = "<C-g>";
								run = "'shell -- rofi -theme fullscreen-preview -show filebrowser -filebrowser-command \"ya emit reveal\" -filebrowser-directory \"$(pwd)\"'";
								desc = "Grid view";
							}
							# mount
							{
								on = [
									"M"
									"m"
								];
								run = "plugin mount";
								desc = "mount";
							}
							{
								on = [
									"M"
									"g"
									"m"
								];
								run = "plugin gvfs -- select-then-mount --jump";
								desc = "Монтировать устройство и перейти";
							}
							{
								on = [
									"M"
									"g"
									"u"
								];
								run = "plugin gvfs -- select-then-unmount";
								desc = "Отмонтировать устройство";
							}
							# gitui
							{
								on = [
									"g"
									"i"
								];
								run = "plugin gitui";
								desc = "gitui";
							}

							# sudo
							# {
							# 	on = ["!"];
							# 	run = "plugin sudo";
							# 	desc = "sudo";
							# }

							# chmod
							{
								on = [
									"c"
									"m"
								];
								run = "plugin chmod";
								desc = "chmod";
							}

							# compress
							{
								on = [
									"c"
									"a"
								];
								run = "plugin compress";
								desc = "compress";
							}

							# mediainfo
							{
								on = [
									"m"
									"i"
								];
								run = "plugin mediainfo";
								desc = "media info";
							}

							# toggle pane
							{
								on = ["T"];
								run = "plugin toggle-pane";
								desc = "toggle pane";
							}
						];
					};
				};
			};
		};
	};
}
