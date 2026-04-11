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
}
