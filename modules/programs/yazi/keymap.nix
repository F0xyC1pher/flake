{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			programs.yazi = {
				keymap = {
					mgr = {
						prepend_keymap = [
							# mount
							{
								on = ["M" "M"];
								run = "plugin mount";
								desc = "mount";
							}
							{
								on = ["M" "g"];
								run = "plugin gvfs -- select-then-mount --jump";
								desc = "Монтировать устройство и перейти";
							}
							{
								on = ["M" "g" "u"];
								run = "plugin gvfs -- select-then-unmount";
								desc = "Отмонтировать устройство";
							}
							# gitui
							{
								on = ["g" "i"];
								run = "plugin gitui";
								desc = "gitui";
							}

							# sudo
							{
								on = ["!"];
								run = "plugin sudo";
								desc = "sudo";
							}

							# chmod
							{
								on = ["c" "m"];
								run = "plugin chmod";
								desc = "chmod";
							}

							# compress
							{
								on = ["c" "a"];
								run = "plugin compress";
								desc = "compress";
							}

							# mediainfo
							{
								on = ["m" "i"];
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
