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
								on = [
									"<Esc>"
								];
								run = "close";
								desc = "Cancel input";
							}
							{
								on = [
									"!"
								];
								run = "shell \"$SHELL\" --block";
								desc = "Open $SHELL here";
							}
							{
								on = [
									"M"
									"i"
									"m"
								];
								desc = "Mount ISO";
								run = ''shell 'd=$(udisksctl loop-setup -f "$0" | sed -n "s/.*as \(loop[0-9]*\)\./\1/p") && udisksctl mount -b "/dev/$d"' --block --confirm'';
							}
							{
								on = [
									"M"
									"i"
									"u"
								];
								desc = "Unmount ISO";
								run = ''shell 'd=$(losetup -j "$0" | cut -d: -f1 | head -n1) && udisksctl unmount -b "$d" && udisksctl loop-delete -b "$d"' --block --confirm'';
							}
							{
								on = "<C-g>";
								# run = "'shell -- rofi -theme fullscreen-preview -modi filebrowser -show filebrowser -filebrowser-command \"ya emit reveal\" -filebrowser-directory \"$(pwd)\"'";
								run = "shell \"$SHELL\" --block";

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
							# 	on = [
							# 		"<C>-!"
							#		];
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
								on = [
									"T"
								];
								run = "plugin toggle-pane";
								desc = "toggle pane";
							}

							{
								on = ["<Right>"];
								run = "plugin fuse-archive -- mount";
								desc = "Enter or Mount selected archive";
							}
							{
								on = ["<Left>"];
								run = "plugin fuse-archive -- leave";
								desc = "Leave selected archive without unmount it";
							}
							{
								on = ["l"];
								run = "plugin fuse-archive -- mount";
								desc = "Enter or Mount selected archive";
							}
							{
								on = ["h"];
								run = "plugin fuse-archive -- leave";
								desc = "Leave selected archive without unmount it";
							}

							# add --hide-download-notify to hide "Downloading hovered file, will auto-mount after it's finished"
							# {
							# 	on = ["l"];
							# 	run = "plugin fuse-archive -- mount --hide-download-notify";
							# 	desc = "Enter or Mount selected archive";
							# }
							# {
							# 	on = ["<Right>"];
							# 	run = "plugin fuse-archive -- mount --hide-download-notify";
							# 	desc = "Enter or Mount selected archive";
							# }

							# Over quit command for yazi <= v25.5.31 to unmount on quit. For (>=v25.12.29) yazi, you don't need to add these lines.
							# {
							# 	on = ["q"];
							# 	run = ["plugin fuse-archive -- unmount" "quit"];
							# 	desc = "Quit the process";
							# }
							# {
							# 	on = ["Q"];
							# 	run = ["plugin fuse-archive -- unmount" "quit --no-cwd-file"];
							# 	desc = "Quit without outputting cwd-file";
							# }

							# Or if you use project.yazi or other plugin that call quit command internally, just keep in mind to add unmount command before quit command.
							# Even with nightly yazi
							# {
							# 	on = ["q"];
							# 	run = ["plugin fuse-archive -- unmount" "plugin projects -- quit"];
							# 	desc = "Quit the process";
							# }
						];
					};
				};
			};
		};
	};
}
