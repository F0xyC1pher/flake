{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {pkgs, ...}: {
			programs.micro = {
				package = pkgs.micro-full;
				enable = true;
				settings = {
					showchars = "itab=│"; # Показывать отступы как │ (для spaces и tabs; настройте символ по вкусу, например "┊" или "┆")
					hltrailingws = false; # Подсвечивать trailing whitespace (для видимости лишних пробелов)
					tabstospaces = false; # Конвертировать tabs в spaces (default false)
					tabsize = 4; # Ширина tab
				};
			};
		};
	};
}
