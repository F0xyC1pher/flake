{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: let
			t = vars.theme.style;
		in {
			programs.firefox = {
				profiles.${vars.user.fullName} = {
					userContent = ''
						/* ── Полный сброс холста для всех внешних сайтов ───────────── */
						@-moz-document regexp("^(?!moz-extension://|about:).*$") {
						  :root, :root::before, :root::after, html, body {
						    background-color: transparent !important;
						    background-image: none !important;
						  }
						}
						/* ── Скроллбар под стиль системы ────────────────────────────── */
						* {
						  scrollbar-color: ${t.ui.selection} ${t.ui.main} !important;
						}
					'';
				};
			};
		};
	};
}
