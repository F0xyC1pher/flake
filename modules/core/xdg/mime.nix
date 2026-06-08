{...}: {
	xdg = {
		mime = {
			enable = true;
			defaultApplications = {
				"inode/directory" = ["yazi.desktop"];
				"x-scheme-handler/terminal" = ["kitty.desktop"];
				"application/x-terminal-emulator" = ["kitty.desktop"];
				"text/*" = ["dev.zed.Zed.desktop"];
			};
		};
	};
}
