let
	hardware = import ./hardware.nix;
	colors = import ./colors.nix;
in
{
	# Подключаем переменные из hardware и colors
	inherit hardware colors;
	
	# Подстановка переменных в различные ебеня системы
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
	# Загрузчик
	bootLoader = "Limine"; #Limine или GRUB
}
