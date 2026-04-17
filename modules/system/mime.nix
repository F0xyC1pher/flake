{...}: {
	xdg = {
		mime.enable = true;
		mime.defaultApplications = {
			"inode/directory" = ["yazi.desktop"];
			"x-scheme-handler/terminal" = ["kitty.desktop"];
			"application/x-terminal-emulator" = ["kitty.desktop"];
			"text/*" = ["codium.desktop"];
		};
	};
}
