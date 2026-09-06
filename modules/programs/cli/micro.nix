{
	inputs,
	vars,
	...
}: let
	style = vars.theme.style;
	colors = vars.theme.colors;
in {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {pkgs, ...}: {
			programs.micro = {
				package = pkgs.micro-full;
				enable = true;
				settings = {
					showchars = "itab=│"; #"┊" "┆"
					hltrailingws = true;
					cursorline = true;
					rmtrailingws = true;
					tabstospaces = false;
					tabsize = 4;
					colorscheme = "custom-theme";
					autosu = true;
				};
			};

			xdg.configFile."micro/colorschemes/custom-theme.micro".text = ''
				# Основные цвета интерфейса
				color-link default "${style.text.main},${style.ui.bg}"
				color-link comment "${style.text.comment}"
				color-link cursor-line "${style.ui.overlay}"
				color-link selection "${style.text.onAccent},${style.ui.border.active}"
				color-link line-number "${style.text.dimmed},${style.ui.bg}"
				color-link current-line-number "${style.text.heading},${style.ui.surface}"
				color-link statusline "${style.text.main},${style.ui.surface}"
				color-link tabbar "${style.text.dimmed},${style.ui.bg}"
				color-link tab-active "${style.text.heading},${style.ui.surface}"
				color-link divider "${style.ui.border.inactive},${style.ui.bg}"
				color-link color-column "${style.ui.overlay}"
				color-link indent-char "${style.ui.overlay}"

				# Синтаксис
				color-link keyword "${style.text.syntax.keyword}"
				color-link keyword.statement "${style.text.syntax.keyword}"
				color-link keyword.control "${style.text.syntax.keyword}"
				color-link symbol "${style.text.syntax.keyword}"
				color-link symbol.operator "${style.text.syntax.keyword}"
				color-link symbol.brackets "${style.text.light}"

				color-link identifier "${style.text.main}"
				color-link identifier.class "${style.text.syntax.function}"
				color-link identifier.var "${style.text.main}"
				color-link type "${style.text.syntax.function}"
				color-link type.keyword "${style.text.syntax.keyword}"

				color-link statement "${style.text.syntax.keyword}"
				color-link preproc "${style.text.syntax.warning}"

				color-link constant "${style.text.syntax.number}"
				color-link constant.numeric "${style.text.syntax.number}"
				color-link constant.bool "${style.text.syntax.number}"
				color-link constant.string "${style.text.syntax.string}"
				color-link constant.string.char "${style.text.syntax.string}"

				color-link special "${style.text.syntax.match}"
				color-link underlined "underline ${style.text.syntax.info}"
				color-link error "bold ${style.text.syntax.error}"
				color-link todo "bold ${style.text.syntax.warning}"

				# Сообщения и поиск
				color-link message "${style.text.main},${style.ui.surface}"
				color-link error-message "${style.text.onAccent},${style.text.syntax.error}"
				color-link match-brace "${style.text.onAccent},${style.text.syntax.match}"
			'';
		};
	};
}
