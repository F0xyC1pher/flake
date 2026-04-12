{...}: let
	#чистый набор цветов
	colors = import ./colors.nix;
	#тема определяет какие цвета использовать
	theme =
		import ./theme.nix {
			vars = {inherit colors;};
		};
in {
	inherit theme colors;
	# переменные
	userFullName = "Foxy_Chipher";
	fontName = "FiraCode Nerd Font Mono";
	fontSize = 12;
	shell = "fish";
	terminal = "kitty";
}
