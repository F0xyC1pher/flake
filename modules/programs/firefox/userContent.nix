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
