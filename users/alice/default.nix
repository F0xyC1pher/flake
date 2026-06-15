{lib, ...}: {
	theme = {
		name = "theMe";
		accent = "0";
	};

	programs = {
		cli = ["yazi" "zoxide" "git" "tmux"];
		gui = ["firefox" "kitty" "fuzzel"];
		media = ["pipewire" "mpd"];
	};

	desktop = "niri"; # можно "driftwm", "dms" и т.д.

	userFullName = "Alice";
	# Замени пароль на свой (или используй hashedPassword)
	userPassword = "$6$AntMCBLfJ4foukEM$UrkX24HXtg4oUToaOv6YNzoTigCoYX9CbbyY0pNRk6ZmVG/3StBux6gDWA1dWSIE490PF4Q/YFcVixA7gc8zy.";
	shell = "fish";
	terminal = "kitty";
}
