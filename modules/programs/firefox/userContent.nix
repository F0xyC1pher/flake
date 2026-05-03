{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: let
			t = vars.style.theme;
			c = vars.style.colors.accent;
		in {
			programs.firefox = {
				profiles.${vars.userFullName} = {
					userContent = ''
						/* ── Page defaults ──────────────────────────────────────────── */
						@-moz-document url("about:newtab"), url("about:home"), url("about:blank") {
						  body {
						    background-color: ${t.ui.main} !important;
						    color:            ${t.text.main} !important;
						  }
						}

						/* ── Scrollbar ──────────────────────────────────────────────── */
						* {
						  scrollbar-color: ${t.ui.selection} ${t.ui.main} !important;
						}
					'';
				};
			};
		};
	};
}
