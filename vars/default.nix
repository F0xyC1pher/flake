{
	# Имя учётной записи в системе
	userName = "f";
	# Полное имя пользователя в описании учётной записи в системе и профиль в firefox
	userFullName = "Foxy_Chipher";
	# Хостнейм компьютера в сети
	hostName = "p";
	# Имя Шрифта
	fontName = "FiraCode Nerd Font Mono";
	# Размер шрифта
	fontSize = 12;
	# Оболочка Эмулятора Терминала
	shell = "fish"; # fish bash zsh
	# Эмулятор Терминала
	terminal = "kitty"; # kitty alacritty ghostty
	nixos-hw = "none"; # null или "none" чтобы отключить, строка для железа
	# Модули (true или false)
	nvidia = {
		enable = true;# <- автообнаружение в будущем
		Prime = false;
		MaxPerfomance = true;
	};
	bluetooth = true;
	wifi = true;
}
