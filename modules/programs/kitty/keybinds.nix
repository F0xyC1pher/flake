# ── Kitty keybindings ─────────────────────────────────────────────────────────
{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: {
			programs.kitty.keybindings = {
				# Табы
				"ctrl+shift+t" = "new_tab";
				"ctrl+shift+q" = "close_tab";
				"ctrl+tab" = "next_tab";
				"ctrl+shift+tab" = "previous_tab";

				# Сплиты (закомментированы — раскомментить при необходимости)
				# "ctrl+shift+enter" = "launch --location=hsplit --cwd=current";
				# "ctrl+enter"       = "launch --location=vsplit --cwd=current";

				# Навигация между окнами
				# "ctrl+shift+[" = "previous_window";
				# "ctrl+shift+]" = "next_window";

				# Переключение layout
				# "ctrl+shift+l" = "next_layout";
			};
		};
	};
}
