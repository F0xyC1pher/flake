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
					userChrome = ''
						#TabsToolbar { visibility: collapse !important; }
						#sidebar-header { display: none !important; }
						:root {
						  --bg-deep:       ${t.ui.deep};
						  --bg-main:       ${t.ui.main};
						  --bg-surface:    ${t.ui.surface};
						  --bg-overlay:    ${t.ui.overlay};
						  --bg-selection:  ${t.ui.selection};
						  --fg-main:       ${t.text.main};
						  --fg-heading:    ${t.text.heading};
						  --fg-faint:      ${t.text.faint};
						  --accent:        ${t.accent};
						  --accent-fg:     ${t.text.onAccent};
						  --border-active: ${t.ui.border.active};
						  --border-inact:  ${t.ui.border.inactive};
						  --success:       ${t.text.syntax.success};
						  --warning:       ${t.text.syntax.warning};
						  --error:         ${t.text.syntax.error};
						  --info:          ${t.text.syntax.info};
						  /* Remap Firefox built-in vars */
						  --toolbar-bgcolor:       var(--bg-surface) !important;
						  --toolbar-color:         var(--fg-main)    !important;
						  --tab-selected-bgcolor:  var(--bg-main)    !important;
						  --tab-selected-color:    var(--accent)     !important;
						  --urlbar-box-bgcolor:    var(--bg-overlay) !important;
						  --urlbar-box-focus-bgcolor: var(--bg-overlay) !important;
						  --urlbar-box-hover-bgcolor: var(--bg-overlay) !important;
						  --input-bgcolor:         var(--bg-overlay) !important;
						  --input-color:           var(--fg-main)    !important;
						  --button-bgcolor:        var(--bg-surface) !important;
						  --button-hover-bgcolor:  var(--bg-overlay) !important;
						  --button-active-bgcolor: var(--accent)     !important;
						  --sidebar-background-color: var(--bg-surface) !important;
						}
						/* ── Square mode ───────────────────────────────────────────── */
						* { border-radius: 0 !important; }

						/* ── Nav bar ───────────────────────────────────────────────── */
						#navigator-toolbox { border-bottom: 1px solid var(--border-inact) !important; }

						/* ── Tabs ───────────────────────────────────────────────────── */
						.tabbrowser-tab {
						  color: var(--fg-faint) !important;
						}
						.tabbrowser-tab[selected] .tab-label {
						  color: var(--accent) !important;
						  font-weight: bold !important;
						}
						.tab-bottom-line {
						  background-color: var(--accent) !important;
						}
						/* ── URL bar ────────────────────────────────────────────────── */
						#urlbar-background {
						  background-color: var(--bg-overlay)  !important;
						  border:           1px solid var(--border-inact) !important;
						}
						#urlbar[focused] > #urlbar-background {
						  border-color: var(--accent) !important;
						}
						#urlbar-input { color: var(--fg-main) !important; }
						/* ── Sidebar ────────────────────────────────────────────────── */
						#sidebar-box { background-color: var(--bg-surface) !important; }
						#sidebar-header { border-bottom: 1px solid var(--border-inact) !important; }
						/* ── Find bar ───────────────────────────────────────────────── */
						.findbar-textbox { background-color: var(--bg-overlay) !important; color: var(--fg-main) !important; }
						.found-matches   { color: var(--success) !important; }
					'';
				};
			};
		};
	};
}
