{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			programs.kitty.keybindings = {
				# Табы
				"ctrl+t" = "new_tab";
				"ctrl+q" = "close_tab";
				"ctrl+tab" = "next_tab";
				"ctrl+shift+tab" = "previous_tab";

				# Сплиты
				# "ctrl+shift+enter" = "launch --location=hsplit --cwd=current";
				# "ctrl+enter" = "launch --location=vsplit --cwd=current";

				# Навигация между окнами
				# "ctrl+shift+<" = "previous_window";
				# "ctrl+shift+[" = "previous_window";
				# "ctrl+shift+>" = "next_window";
				# "ctrl+shift+]" = "next_window";

				# Закрытие окна
				# "ctrl+shift+q" = "close_window";

				# Переключение layout
				# "ctrl+shift+l" = "next_layout";
			};
		};
	};
}
